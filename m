Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265842AbSKBAqH>; Fri, 1 Nov 2002 19:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSKBAqH>; Fri, 1 Nov 2002 19:46:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:394 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265842AbSKBAqG>; Fri, 1 Nov 2002 19:46:06 -0500
Subject: Re: [PATCH] IDE BIOS timings, autotune cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20021102000219.GM1669@tmathiasen>
References: <20021102000219.GM1669@tmathiasen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 01:12:57 +0000
Message-Id: <1036199577.14840.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 00:02, Torben Mathiasen wrote:
> Hi,
> 
> The attached patch cleans up the 'autotune' concept used in the current 2.4
> IDE driver. It also adds support for using pure BIOS IDE timings with DMA/PIO.
> On some systems the BIOS has a far better overview on how things are connected
> (some chipsets don't support >ata66 speed detection, etc).
> 

Interesting idea. However you are working on whats effectively a dead
codebase.

