Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291480AbSBHI6b>; Fri, 8 Feb 2002 03:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291484AbSBHI6N>; Fri, 8 Feb 2002 03:58:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15117 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291480AbSBHI6I>;
	Fri, 8 Feb 2002 03:58:08 -0500
Date: Fri, 8 Feb 2002 09:57:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
Message-ID: <20020208095739.J4942@suse.de>
In-Reply-To: <3C639060.A68A42CA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C639060.A68A42CA@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08 2002, Andrew Morton wrote:
> Here's a patch which addresses the get_request starvation problem.

[snip]

Agrh, if only I knew you were working on this too :/. Oh well, from a
first-read the patch looks good.

-- 
Jens Axboe

