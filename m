Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSGNX33>; Sun, 14 Jul 2002 19:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSGNX32>; Sun, 14 Jul 2002 19:29:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:36854 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317217AbSGNX30>; Sun, 14 Jul 2002 19:29:26 -0400
Subject: Re: Status of DRI modules for i810 with > 2.4.19-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020714220922.61652.qmail@web10404.mail.yahoo.com>
References: <20020714220922.61652.qmail@web10404.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 01:41:55 +0100
Message-Id: <1026693715.13886.97.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 23:09, Steve Kieu wrote:
> 
> No, it is not fixed yet! I attched the dmesg.log but
> if required I will make the result through ksymoop. 

Duplicate the problem with a 2.4.19-rc1-ac3 kernel (not one with random
pre-empt patches). Then get a traceback. Also be sure to use XFree86 4.2
or later

