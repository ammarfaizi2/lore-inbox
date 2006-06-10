Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWFJAQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWFJAQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWFJAQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:16:27 -0400
Received: from quechua.inka.de ([193.197.184.2]:20637 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932603AbWFJAQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:16:26 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <448A07EC.6000409@garzik.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1For9M-0005jT-00@calista.eckenfels.net>
Date: Sat, 10 Jun 2006 02:16:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
> Yes.  Re-read what I wrote.  To put it another way, "mkfs S1 + resize to 
> S2" does not produce precisely the same layout as "mkfs S2".

This is normal for ext3 since it creates less inodes, right?

Gruss
Bernd
