Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUDFAqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUDFAqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:46:34 -0400
Received: from [212.28.208.94] ([212.28.208.94]:61701 "HELO dewire.com")
	by vger.kernel.org with SMTP id S263567AbUDFAqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:46:30 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
Date: Tue, 6 Apr 2004 02:46:25 +0200
User-Agent: KMail/1.6.1
Cc: Timothy Miller <miller@techsource.com>, John Stoffel <stoffel@lucent.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <20040405225250.86703.qmail@web40504.mail.yahoo.com>
In-Reply-To: <20040405225250.86703.qmail@web40504.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200404060246.25327.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 00:52, you wrote:
> --- Robin Rosenberg <robin.rosenberg.lists@dewire.com>
>
> wrote:
> > On Monday 05 April 2004 23:30, Sergiy Lozovsky
> >
> > wrote:
> > > Point me to ANy langage with VM around 100K.
> >
> > There is a Java VM (lejos) för the Lego Mindstorms
> > robot. The hardware
> > has 32K memory.
>
> Is it Free and Open Source? Where can I get it if it
> is?

www.lejos.org.  Mozilla License 1.0 (Not sure about GPL compatibility if you 
were to have wierd plans).

But, it has no GC- I doubt adding GC would add many K's. On the other hand you 
might want to be careful with GC inside the kernel :-)

-- robin
