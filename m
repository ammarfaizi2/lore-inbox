Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTBOScK>; Sat, 15 Feb 2003 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbTBOScK>; Sat, 15 Feb 2003 13:32:10 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:40117 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S264836AbTBOScJ>; Sat, 15 Feb 2003 13:32:09 -0500
Date: Sat, 15 Feb 2003 13:41:52 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: A long time ago , (was re: 2.5.7 oops & ksymoops 2.4.5 & libbfd..)
In-Reply-To: <6748.1038199294@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.53.0302151335170.6988@filesrv1.baby-dragons.com>
References: <6748.1038199294@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Keith ,  If you would please add this to the link for those
	with this trouble .  It appeasr to be a difficulty in Slackware
	8.0-8.1 distributions .  Some application installs a bad libbdf*
	or libiberty* during the install of the distribution .  This can
	be easily remidied ,  Re install the binutils .  Hth ,  JimL
	ie:
	# Note: Must be root to do this
	#Slackware: In my case the vars are:
	VER="2.12.90.0.9"
	num="1"

	installpkg ${PATH}/binutils-${VER}-i386-${num}.tgz
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
