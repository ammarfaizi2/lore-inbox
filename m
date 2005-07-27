Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVG0OcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVG0OcC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVG0OcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:32:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26261 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262333AbVG0OaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:30:22 -0400
Date: Wed, 27 Jul 2005 16:29:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/linux/bio.h: "extern inline" -> "static inline"
Message-ID: <20050727142912.GJ6920@suse.de>
References: <20050726145344.GO3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726145344.GO3160@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26 2005, Adrian Bunk wrote:
> "extern inline" doesn't make much sense.

Yep, thanks.

-- 
Jens Axboe

