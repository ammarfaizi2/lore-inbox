Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264141AbRFSOAZ>; Tue, 19 Jun 2001 10:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbRFSOAP>; Tue, 19 Jun 2001 10:00:15 -0400
Received: from web3503.mail.yahoo.com ([216.115.111.70]:17171 "HELO
	web3503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264140AbRFSOAN>; Tue, 19 Jun 2001 10:00:13 -0400
Message-ID: <20010619140011.15518.qmail@web3503.mail.yahoo.com>
Date: Tue, 19 Jun 2001 15:00:11 +0100 (BST)
From: =?iso-8859-1?q?Mich=E8l=20Alexandre=20Salim?= 
	<salimma1@yahoo.co.uk>
Subject: PCMCIA DVD-ROM not detected when self-powered
To: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am setting up my notebook (Sony Vaio Picturebook
C1VE) so that I can watch DVD under Linux, and one
stumbling block is that (this is tested under Windows)
the DVD drive has to be self-powered to get an
acceptable performance - audio/video output is very
slow when the drive is powered through PCMCIA, and
this is under Windows with full acceleration.

I have not managed to get the DVD drive (PCG-51A)
detected by pcmcia-cs, using either the kernel pcmcia
drivers or the standalone drivers. Wondering if I am
missing something here..

Thanks in advance,

Michel

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
