Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRKFB2Q>; Mon, 5 Nov 2001 20:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276743AbRKFB2H>; Mon, 5 Nov 2001 20:28:07 -0500
Received: from femail22.sdc1.sfba.home.com ([24.0.95.147]:14502 "EHLO
	femail22.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276708AbRKFB1t>; Mon, 5 Nov 2001 20:27:49 -0500
Message-ID: <000b01c16662$81ccdf00$0300a8c0@theburbs.com>
From: "Jamie" <darkshad@home.com>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: <becker@webserv.gsfc.nasa.gov>, <jam@McQuil.com>, <hendriks@lanl.gov>,
        <jgolds@resilience.com>, <sdegler@degler.net>,
        <tulip-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        "Anders Hedborg" <ahe@systemkoreograferna.com>
In-Reply-To: <000c01c16655$78a1af80$0300a8c0@theburbs.com> <3BE729BB.F84AFAEF@mandrakesoft.com>
Subject: Re: Tulip Drivers Problem in 2.4.xx Kernel
Date: Mon, 5 Nov 2001 20:29:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok Jeff thanks I will definately give that a try I have never tried the
dec4x5 drivers I will see if it works
for my NIC.

Thanks,

Jamie

----- Original Message -----
From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
To: "Jamie" <darkshad@home.com>
Cc: <becker@webserv.gsfc.nasa.gov>; <jam@McQuil.com>; <hendriks@lanl.gov>;
<jgolds@resilience.com>; <sdegler@degler.net>;
<tulip-users@lists.sourceforge.net>; <linux-kernel@vger.kernel.org>; "Anders
Hedborg" <ahe@systemkoreograferna.com>
Sent: Monday, November 05, 2001 7:07 PM
Subject: Re: Tulip Drivers Problem in 2.4.xx Kernel


Currently there is a bug in 2.4.x-current tulip drivers that prevents
21041 from initializing correctly.  Until then you can use the 'de4x5'
driver or download the latest stable version on the tulip web page:
http://sourceforge.net/projects/tulip/
--
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


