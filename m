Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWHJCKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWHJCKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 22:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWHJCKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 22:10:49 -0400
Received: from waste.org ([66.93.16.53]:13211 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030536AbWHJCKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 22:10:49 -0400
Date: Wed, 9 Aug 2006 21:09:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Joern Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] UML - support checkstack
Message-ID: <20060810020922.GO6908@waste.org>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:15:24PM -0400, Jeff Dike wrote:
> Make checkstack work for UML.  We need to pass the underlying architecture
> name, rather than "um" to checkstack.pl.

Does this do the right thing with something like Voyager?

Or should we just get together a small fund to send the remaining
Voyager users proper computers?

-- 
Mathematics is the supreme nostalgia of our time.
