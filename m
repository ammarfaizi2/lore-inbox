Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbVG3Rkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbVG3Rkg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbVG3Rkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:40:36 -0400
Received: from 66-189-87-63.static.oxfr.ma.charter.com ([66.189.87.63]:45582
	"EHLO lakshmi.solana.com") by vger.kernel.org with ESMTP
	id S263078AbVG3Rka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:40:30 -0400
Date: Sat, 30 Jul 2005 12:02:18 -0400
From: Jeff Dike <jdike@addtoit.com>
To: blaisorblade@yahoo.it
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/3] uml: share page bits handling between 2 and 3 level pagetables
Message-ID: <20050730160218.GB4585@ccure.user-mode-linux.org>
References: <20050728185655.9C6ADA3@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728185655.9C6ADA3@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 08:56:53PM +0200, blaisorblade@yahoo.it wrote:
> As obvious, a "core code nice cleanup" is not a "stability-friendly patch" so
> usual care applies.

These look reasonable, as they are what we discussed in Ottawa.

I'll put them in my tree and see if I see any problems.  I would
suggest sending these in early after 2.6.13 if they seem OK.

				Jeff
