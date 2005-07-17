Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVGQNpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVGQNpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 09:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVGQNpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 09:45:22 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53890 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261279AbVGQNpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 09:45:20 -0400
Date: Sun, 17 Jul 2005 15:45:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Bodo Eggert <7eggert@gmx.de>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [0/5+1] menu -> menuconfig part 1
In-Reply-To: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
Message-ID: <Pine.LNX.4.61.0507171505300.3743@scrub.home>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Jul 2005, Bodo Eggert wrote:

> These patches change some menus into menuconfig options.
> 
> Reworked to apply to linux-2.6.13-rc3-git3

I like it, but I would prefer to give it first a bit more exposure in -mm, 
as it does change the menu structure and the behaviour is little 
different, so I'd like to see if there's a some feedback first from people 
using it.

bye, Roman
