Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275856AbRJKJux>; Thu, 11 Oct 2001 05:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275857AbRJKJun>; Thu, 11 Oct 2001 05:50:43 -0400
Received: from [212.77.202.3] ([212.77.202.3]:12812 "EHLO mail.cbq.com.qa")
	by vger.kernel.org with ESMTP id <S275856AbRJKJub>;
	Thu, 11 Oct 2001 05:50:31 -0400
Message-ID: <018201c15239$f4a7dda0$b00b0180@TALHA>
Reply-To: "Syed Mohammad Talha" <talha@cbq.com.qa>
From: "Syed Mohammad Talha" <talha@cbq.com.qa>
To: =?iso-8859-1?Q?Pekka_Pietik=E4inen?= <pp@netppl.fi>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20011011105016.C28145@devcon.net> <E15rc5o-0002cH-00@the-village.bc.nu> <9q3p56$tqo$1@forge.intermeta.de> <20011011124144.A20659@netppl.fi>
Subject: Re: Tainted Modules Help Notices
Date: Thu, 11 Oct 2001 12:48:56 +0300
Organization: Commercial Bank of Qatar
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have just subscribed this mailing list and sent mail to
linux-vger.kernel.org but this seems that I am missing something, because I
cant see my mail on the list and also have no idea whether this is the right
place to discuss or not, if not please excuse me, if yes than please help. I
have an IBM e-server and have installed redhat 7.1 with kernel 2.4.2, now
when I am trying to upgrade the kernel I am unable to do so. This has the
SCSI HDD and controller aic7xxx. I am upgrading the new kernel 2.4.10 now
when I start compiling the kernel every things goes ok but when I makes the
initrd image it gives different errors, like

modules for aic7xxx not found or
all loopback devices busy

I am selecting all the options in the kernel compilation as per my knowledge
and adopting the ways defined to compile, I have compiled the same kernel on
an IDE drive and is working fine and did not gave any error, but on scsci I
am very badly stuck, I can make the initrd image from the old modules
directory and define in the lilo.conf with the new kernel it works. Once I
was successful in making the initrd image through the new kernel module
directory but this was of no use, because when I rebooted the machine there
was a kernel panic


So guruz please if u can help me in resolving this problem, I am not sure
that whether I am selecting the wrong choices in the kernel compilation or
there is something else. Also when I compared the old module directory which
was of the default installed kernel and which I compile are quite different.


Looking for help

Talha

