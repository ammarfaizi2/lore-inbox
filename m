Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264436AbTCXVzA>; Mon, 24 Mar 2003 16:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264437AbTCXVzA>; Mon, 24 Mar 2003 16:55:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31164 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264436AbTCXVy6>;
	Mon, 24 Mar 2003 16:54:58 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 24 Mar 2003 23:06:05 +0100 (MET)
Message-Id: <UTC200303242206.h2OM65A29479.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Cc: akpm@digeo.com, hch@infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still don't know what we need ranges or even subranges for.
> What problem are you trying to solve?

I mentioned the structure of Al's block device code to you.
Haven't you read blk_register_region()?

Andries

