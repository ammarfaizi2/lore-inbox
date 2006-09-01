Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWIAOQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWIAOQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWIAOQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:16:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30942 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932072AbWIAOQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:16:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060901135055.GA18276@stusta.de> 
References: <20060901135055.GA18276@stusta.de>  <20060901015818.42767813.akpm@osdl.org> <44F80F0D.70100@zen.co.uk> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Grant Wilson <grant.wilson@zen.co.uk>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [-mm patch] drivers/md/Kconfig: fix BLOCK dependency 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 01 Sep 2006 15:15:11 +0100
Message-ID: <11281.1157120111@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> -if CONFIG_BLOCK
> +if BLOCK

Oops.

Acked-By: David Howells <dhowells@redhat.com>
