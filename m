Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUJaJL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUJaJL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 04:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUJaJL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 04:11:29 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:52944 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261413AbUJaJL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 04:11:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EpfUBRwoq82rtkU8Q1boJbFhC+L2fIf1FtN44VnDoG6jhK99gToOoNaqjCKvSdGhdjOxzBTAoBj1tVJhrtkzP1fHBmvLm+W8mEdwcIGZ0WX+BQUEZnW2S54yqPFn0yBN/Qd7LC3kgKfFXHJQTfdwX4Fwiu1FLU2Q78ht2bR8/QQ=
Message-ID: <21d7e99704103101114fda4f4b@mail.gmail.com>
Date: Sun, 31 Oct 2004 20:11:26 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] DRM: remove unused functions
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20041028221535.GL3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041028221535.GL3207@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below removes two unused functions from DRM.
> 
> diffstat output:
>  drivers/char/drm/i810_dma.c |   18 ------------------
>  drivers/char/drm/i915_dma.c |   18 ------------------
>  2 files changed, 36 deletions(-)
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Dave Airlie <airlied@linux.ie>
