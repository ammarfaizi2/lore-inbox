Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbULPBO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbULPBO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbULPBOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:14:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:32677 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262539AbULPAnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:43:08 -0500
Date: Thu, 16 Dec 2004 01:53:35 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH N/30] return statement cleanup - kill pointless parentheses
 in fs/xfs/*
In-Reply-To: <20041216113943.A480215@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0412160151420.3864@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412160115370.3864@dragon.hygekrogen.localhost>
 <20041216113943.A480215@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Nathan Scott wrote:

> On Thu, Dec 16, 2004 at 01:16:55AM +0100, Jesper Juhl wrote:
> > This patch removes pointless parentheses from return statements in 
> > fs/xfs/*
> > 
> 
> Thanks, but no thanks.  This sort of "noise" diff makes comparing
> new versions of a file/routine/... to older versions much more
> difficult than need be, for no gain really.
> 
Ok, fair enough, I'll strike fs/xfs/ from my todo list.  a few more are 
already send - just ignore those then, please.

Seems eople have different oppinions on this.....

-- 
Jesper Juhl


