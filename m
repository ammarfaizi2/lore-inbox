Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbTL0XND (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 18:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTL0XND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 18:13:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32261
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264874AbTL0XMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 18:12:55 -0500
Date: Sat, 27 Dec 2003 15:11:27 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x CONFIG_BLK_DEV_IDE_MODES long dead
In-Reply-To: <m3pteaoz1x.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.4.10.10312271510260.32122-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Would you like to explain why they are gone?
Just to humor the oldman.

Andre Hedrick
LAD Storage Consulting Group

On Sat, 27 Dec 2003, Krzysztof Halasa wrote:

> Hi,
> 
> It looks CONFIG_BLK_DEV_IDE_MODES has been killed by patch-2.4.21.
> The attached patch removes the zombies from 2.4.24pre2 kernel.
> 
> 2.6 kernel is already free of them.
> -- 
> Krzysztof Halasa, B*FH
> 

