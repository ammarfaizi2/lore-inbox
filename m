Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWARCCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWARCCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWARCCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:02:12 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:21179 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751327AbWARCCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:02:11 -0500
Date: Tue, 17 Jan 2006 21:53:54 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
Message-ID: <20060118025354.GA13825@ccure.user-mode-linux.org>
References: <20060117235659.14622.18544.stgit@zion.home.lan> <20060118001920.14622.79573.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118001920.14622.79573.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 01:19:21AM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> Done by Jeff around January for ubd only, later lost, then restored in his tree
> - however I'm merging it now since there's no reason to leave this here.

The original was dinged by hch for covering over a problem without really
fixing it.

We need to think about this one some more.

				Jeff
