Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293541AbSCSC0R>; Mon, 18 Mar 2002 21:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293527AbSCSC0H>; Mon, 18 Mar 2002 21:26:07 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:19074 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S293541AbSCSC0B>; Mon, 18 Mar 2002 21:26:01 -0500
Date: Mon, 18 Mar 2002 21:26:00 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Looking to do userless input 'make *config' .
Message-ID: <Pine.LNX.4.44.0203182055340.275-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  I have a .config file that has only the needed items
	defined .  What I am looking to do is have the 'make *config'
	be in a script that builds a kernel .  I'd like to have all
	entries that would pop up in a 'make oldconfig' as undefined
	be defined as 'N' .  I am not looking for this to cross major
	kernel versions (ie: 2.4 -> 2.5) just to many possible changes in
	the code .  Does anyone have any pointers ?  Tia ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

