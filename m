Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSLYVnq>; Wed, 25 Dec 2002 16:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSLYVnq>; Wed, 25 Dec 2002 16:43:46 -0500
Received: from m83-mp1.cvx2-c.ren.dial.ntli.net ([62.252.152.83]:42229 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261354AbSLYVnq>; Wed, 25 Dec 2002 16:43:46 -0500
Subject: Re: 2.4.21-pre2 hdparm Kernel Oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bob <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1040374707.1476.12.camel@localhost.localdomain>
References: <1040374707.1476.12.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Dec 2002 21:50:45 +0000
Message-Id: <1040853045.1104.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-20 at 08:58, Bob wrote:
> Hi. I haven't seen any discussions about the 2.4.21-pre1 and pre2
> kernels kernel panicing when you execute  
> /sbin/hdparm -d1 -c3 -m16 -k1 /dev/hdb
> /sbin/hdparm -d1 -c3 -m16 -k1 /dev/hda

Please provide controller and drive info and the call traceback

