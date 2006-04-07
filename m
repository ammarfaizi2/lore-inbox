Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWDGREb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWDGREb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWDGREb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:04:31 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:706 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964816AbWDGREb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:04:31 -0400
Date: Fri, 7 Apr 2006 12:05:40 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 08/17] uml: prepare fixing compilation output
Message-ID: <20060407160540.GB4962@ccure.user-mode-linux.org>
References: <20060407142709.19201.99196.stgit@zion.home.lan> <20060407143107.19201.23684.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407143107.19201.23684.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 04:31:08PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Move the build of user-offsets to arch/um/Kbuild, this will allow using the
> normal user-objs machinery. I had written this to fixup for a Kbuild change, but
> another fix was merged. This is still useful however.

What's the benefit of this?

			Jeff
