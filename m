Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSLHBIA>; Sat, 7 Dec 2002 20:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLHBIA>; Sat, 7 Dec 2002 20:08:00 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:49333 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265092AbSLHBH5>; Sat, 7 Dec 2002 20:07:57 -0500
Subject: Re: [BUG] 2.4.20-BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212071434.11514.m.c.p@wolk-project.de>
References: <200212071434.11514.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 01:51:31 +0000
Message-Id: <1039312291.27923.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 13:35, Marc-Christian Petersen wrote:
> Hi Alan,
> 
> using 2.4.20-BK tree gives me:
> 
> flushing ide devices: hda hdd

Marcelo dropped some of the patches I sent (or his mailer or some random
box in between did). You also want the ll_rw_blk change from -ac

