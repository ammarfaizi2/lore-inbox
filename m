Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSLHStW>; Sun, 8 Dec 2002 13:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSLHStW>; Sun, 8 Dec 2002 13:49:22 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:64953 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261518AbSLHStV>; Sun, 8 Dec 2002 13:49:21 -0500
Subject: Re: PROBLEM: Oops.. NULL pointer reference in 2.4.20-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Simon Ward <simon.ward@cs.man.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <87hedo8i84.fsf@devron.myhome.or.jp>
References: <Pine.LNX.4.44.0212081222370.22353-100000@tl009.cs.man.ac.uk>
	<1039357173.6912.4.camel@irongate.swansea.linux.org.uk> 
	<87hedo8i84.fsf@devron.myhome.or.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 19:28:04 +0000
Message-Id: <1039375684.6942.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that will do the trick. I've got a sort of bad fix in 2.5.50-ac
I was trying but need to clean up properly.


