Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVBBPMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVBBPMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVBBPMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:12:40 -0500
Received: from smtp7.wanadoo.fr ([193.252.22.24]:3114 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262416AbVBBPM3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:12:29 -0500
X-ME-UUID: 20050202151225876.D60CF1800087@mwinf0701.wanadoo.fr
Subject: Re: Accelerated frame buffer functions
From: Xavier Bestel <xavier.bestel@free.fr>
To: Haakon Riiser <haakon.riiser@fys.uio.no>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050202142155.GA2764@s>
References: <20050202133108.GA2410@s>
	 <Pine.LNX.4.61.0502020900080.16140@chaos.analogic.com>
	 <20050202142155.GA2764@s>
Content-Type: text/plain; charset=utf-8
Date: Wed, 02 Feb 2005 16:11:29 +0100
Message-Id: <1107357093.6191.53.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 02 février 2005 à 15:21 +0100, Haakon Riiser a écrit :

> How can I use a frame buffer driver's optimized copyarea, fillrect,
> blit, etc. from userspace?  The only way I've ever seen anyone use
> the frame buffer device is by mmap()ing it and doing everything
> manually in the mapped memory.  I assume there must be ioctls for
> accessing the accelerated functions, but after several hours of
> grepping and googling, I give up. :-(

Did you try DirectFB ?

	Xav


