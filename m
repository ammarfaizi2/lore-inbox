Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288160AbSAHQcD>; Tue, 8 Jan 2002 11:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288159AbSAHQby>; Tue, 8 Jan 2002 11:31:54 -0500
Received: from web20507.mail.yahoo.com ([216.136.226.142]:28435 "HELO
	web20507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288158AbSAHQbm>; Tue, 8 Jan 2002 11:31:42 -0500
Message-ID: <20020108163141.57751.qmail@web20507.mail.yahoo.com>
Date: Tue, 8 Jan 2002 17:31:41 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: i810_audio
To: Mario Mikocevic <mozgy@hinet.hr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i810_audio.c:747: `PI_OR' undeclared (first use in
this function)

Replace PI_OR with PO_SR. It compiled for me after
that.
But my system still hangs after close while Thomas
Gschwidt's
patch works OK.

Still investigating.
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
