Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVGYHZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVGYHZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVGYHZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 03:25:25 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:41942 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261673AbVGYHZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 03:25:23 -0400
Date: Mon, 25 Jul 2005 09:25:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Joern Engel <joern@wh.fh-wedel.de>, dwmw2@infradead.org
Subject: Re: [PATCH] vfree and kfree cleanup in drivers/
Message-ID: <20050725072524.GA10616@wohnheim.fh-wedel.de>
References: <200507232228.00554.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200507232228.00554.jesper.juhl@gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 July 2005 22:27:58 +0200, Jesper Juhl wrote:
>
>  drivers/mtd/devices/mtdram.c        |    3 +--
>  drivers/mtd/ftl.c                   |   11 -----------

This part of the patch has my blessing.

Jörn

-- 
The grand essentials of happiness are: something to do, something to
love, and something to hope for.
-- Allan K. Chalmers
