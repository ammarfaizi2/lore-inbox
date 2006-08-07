Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWHGWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWHGWRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHGWRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:17:18 -0400
Received: from [198.99.130.12] ([198.99.130.12]:32452 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932161AbWHGWRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:17:17 -0400
Date: Mon, 7 Aug 2006 18:17:03 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uml: clean our set_ether_mac
Message-ID: <20060807221703.GD5890@ccure.user-mode-linux.org>
References: <20060806154700.536.32978.stgit@memento.home.lan> <20060806154705.536.49855.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806154705.536.49855.stgit@memento.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 05:47:05PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Clean set_ether_mac usage. Maybe could also be removed, but surely it can't be a
> global function taking a void* argument.
> 
> You may want to defer this patch to next kernel release.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This one I can go along with :-)

Acked-by: Jeff Dike <jdike@addtoit.com>
