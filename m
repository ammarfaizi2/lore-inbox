Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWHGVTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWHGVTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWHGVTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:19:06 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:4292 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932375AbWHGVTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:19:05 -0400
Date: Mon, 7 Aug 2006 17:18:50 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] uml: use -mcmodel=kernel for x86_64
Message-ID: <20060807211850.GB5890@ccure.user-mode-linux.org>
References: <20060806154700.536.32978.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806154700.536.32978.stgit@memento.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 05:47:00PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> +_extra_flags_ = -fno-builtin -m64 -mcmodel=kernel

What exactly does this do, and can you remember why you think it's needed?

				Jeff
