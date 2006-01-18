Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWAQXyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWAQXyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAQXyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:54:41 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:61369 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932549AbWAQXyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:54:40 -0500
Date: Tue, 17 Jan 2006 19:46:31 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] uml: remove leftover from patch revertal
Message-ID: <20060118004631.GA11766@ccure.user-mode-linux.org>
References: <20060117232626.11417.66832.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117232626.11417.66832.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 12:26:27AM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> 
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> I added this line to share this file with UML, but now it's no longer shared so
> remove this useless leftover.

ACK - Thanks, I saw this and meant to remove it with the futex cleanup patch,
but it slipped my mind.

				Jeff
