Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSGARGb>; Mon, 1 Jul 2002 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSGARGa>; Mon, 1 Jul 2002 13:06:30 -0400
Received: from web20511.mail.yahoo.com ([216.136.175.150]:32887 "HELO
	web20511.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315856AbSGARGa>; Mon, 1 Jul 2002 13:06:30 -0400
Message-ID: <20020701170856.25913.qmail@web20511.mail.yahoo.com>
Date: Mon, 1 Jul 2002 19:08:56 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
To: Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org
In-Reply-To: <3D208283.7010106@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > that's simply because I'm not sure if the kernel
> > runs with AC flag on or off. I quickly checked
> > that it's OK from userland.
> 
> AC is only checked when running at CPL==3, i.e.,
> you'll never get an alignment trap in the kernel.

thanks for the tip, I think that with all the feedback
I got, I could rewrite it more cleanly ;-)

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
