Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUL3Hse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUL3Hse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUL3Hsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:48:33 -0500
Received: from mproxy.gmail.com ([216.239.56.248]:32011 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261567AbUL3Hs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:48:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rrPT9kverZ8WX/k8x1UwxYIPACJSJ73p2LVtJZ63/DPJXaAESPjHJXwj0dBAb+PFUH05RiXA2AwyI2gSxNefHVP1+48xx5mRJSC36RiAoUz8Xvff7kJtUMgKRQsYWFkDjDalTdVGYl24l+tO1HtWArmLDhWThFelJ5o+mtohn9c=
Message-ID: <21d7e997041229234860454564@mail.gmail.com>
Date: Thu, 30 Dec 2004 18:48:25 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [bk pull] drm core/personality split
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0412300733380.25314@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0412300733380.25314@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> of .h files to .c files and removes all the DRM() macros.
> 
> For everyone else the diff is up at:
>         http://www.skynet.ie/~airlied/public_html/patches/dri/drm_core_split-26bk.diff
> and it is > 500k.

doh.. patch is actually at

http://www.skynet.ie/~airlied/patches/dri/drm_core_split-26bk.diff

Dave.
