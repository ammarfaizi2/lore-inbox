Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWJJCKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWJJCKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJJCJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:09:45 -0400
Received: from [198.99.130.12] ([198.99.130.12]:47589 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751979AbWJJCJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:09:41 -0400
Date: Mon, 9 Oct 2006 14:11:01 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 00/14] UML: simple changes for 2.6.19
Message-ID: <20061009181101.GD4931@ccure.user-mode-linux.org>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 11:32:12PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> This is the first set of patches for UML for 2.6.19 I send - I have various
> other patches to merge but I'm sending them in separate batches to avoid
> flooding.

ACK to all of these, except for the first one (moving the inclusion of
the arch Makefile), which seems wrong to me.

				Jeff
