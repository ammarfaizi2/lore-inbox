Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTGFP0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 11:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTGFP0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 11:26:19 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:31108 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262385AbTGFP0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 11:26:16 -0400
Date: Sun, 6 Jul 2003 16:40:09 +0100
From: Ian Molton <spyro@f2s.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: bernie@develer.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       andrea@suse.de, peter@chubb.wattle.id.au, akpm@digeo.com
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-Id: <20030706164009.4890ff8d.spyro@f2s.com>
In-Reply-To: <20030706084750.B8146@flint.arm.linux.org.uk>
References: <200307060133.15312.bernie@develer.com>
	<20030706084750.B8146@flint.arm.linux.org.uk>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003 08:47:50 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> 
> > second iteration of the div64.h cleanup + bug fixing.
> > Contains the following changes since the previous release:
> 
> arm26 is Ian Molton.  Please copy Ian on ARM26 matters, not myself.
> Thanks.

FWIW, theres a patch to MAINTAINERS on its way to linus since a week ago
:-)

John Appleby might like to be copied on ARM26 things also.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
