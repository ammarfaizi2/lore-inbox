Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbULPBgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbULPBgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbULPBSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:18:24 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:57747 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262598AbULPAwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:52:20 -0500
Date: Thu, 16 Dec 2004 11:39:44 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH N/30] return statement cleanup - kill pointless parentheses in fs/xfs/*
Message-ID: <20041216113943.A480215@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0412160115370.3864@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0412160115370.3864@dragon.hygekrogen.localhost>; from juhl-lkml@dif.dk on Thu, Dec 16, 2004 at 01:16:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 01:16:55AM +0100, Jesper Juhl wrote:
> This patch removes pointless parentheses from return statements in 
> fs/xfs/*
> 

Thanks, but no thanks.  This sort of "noise" diff makes comparing
new versions of a file/routine/... to older versions much more
difficult than need be, for no gain really.

cheers.

-- 
Nathan
