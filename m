Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWHUG0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWHUG0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 02:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWHUG0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 02:26:55 -0400
Received: from brick.kernel.dk ([62.242.22.158]:50525 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030213AbWHUG0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 02:26:54 -0400
Date: Mon, 21 Aug 2006 08:29:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uninline ioprio_best()
Message-ID: <20060821062904.GI4290@suse.de>
References: <20060820163016.GA4152@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820163016.GA4152@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20 2006, Oleg Nesterov wrote:
> Saves 376 bytes (5 callers) for me.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Applied.

-- 
Jens Axboe

