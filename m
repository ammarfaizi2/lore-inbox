Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRKFAIF>; Mon, 5 Nov 2001 19:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276057AbRKFAH4>; Mon, 5 Nov 2001 19:07:56 -0500
Received: from mail026.mail.bellsouth.net ([205.152.58.66]:53243 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S276097AbRKFAHh>; Mon, 5 Nov 2001 19:07:37 -0500
Message-ID: <3BE729BB.F84AFAEF@mandrakesoft.com>
Date: Mon, 05 Nov 2001 19:07:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie <darkshad@home.com>
CC: becker@webserv.gsfc.nasa.gov, jam@McQuil.com, hendriks@lanl.gov,
        jgolds@resilience.com, sdegler@degler.net,
        tulip-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Anders Hedborg <ahe@systemkoreograferna.com>
Subject: Re: Tulip Drivers Problem in 2.4.xx Kernel
In-Reply-To: <000c01c16655$78a1af80$0300a8c0@theburbs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a bug in 2.4.x-current tulip drivers that prevents
21041 from initializing correctly.  Until then you can use the 'de4x5'
driver or download the latest stable version on the tulip web page: 
http://sourceforge.net/projects/tulip/
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

