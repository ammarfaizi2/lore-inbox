Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVG2AWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVG2AWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVG2AUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:20:23 -0400
Received: from graphe.net ([209.204.138.32]:32430 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261565AbVG2ATt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:19:49 -0400
Date: Thu, 28 Jul 2005 17:19:47 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: pavel@ucw.cz, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
In-Reply-To: <20050728162738.5f270b4c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0507281719340.16563@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
 <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz>
 <Pine.LNX.4.62.0507280804310.23907@graphe.net> <20050728193433.GA1856@elf.ucw.cz>
 <Pine.LNX.4.62.0507281251040.12675@graphe.net> <Pine.LNX.4.62.0507281254380.12781@graphe.net>
 <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz>
 <Pine.LNX.4.62.0507281456240.14677@graphe.net> <20050728221228.GB1872@elf.ucw.cz>
 <Pine.LNX.4.62.0507281559400.15569@graphe.net> <20050728162738.5f270b4c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Andrew Morton wrote:

> Well if you want to go this way I can just drop the TIF_FREEZE stuff and
> use the patches-relative-to-mainline.

I would appreciate that.\

