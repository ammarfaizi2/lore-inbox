Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUFBPBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUFBPBD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUFBPBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:01:03 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:27193 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263095AbUFBPBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:01:01 -0400
Date: Wed, 2 Jun 2004 17:03:04 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Jens Schmalzing <j.s@lmu.de>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] OProfile driver in 2.6
Message-ID: <20040602170304.GA385@zaniah>
References: <hhwu2qs4eq.fsf@alsvidh.mathematik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hhwu2qs4eq.fsf@alsvidh.mathematik.uni-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2004 at 11:19 +0000, Jens Schmalzing wrote:

> Hi,
> 
> I noticed that the driver for the OProfile profiling system, which
> existed in the linuxppc-2.5-benh tree, is disabled in the mainline,
> even though the driver still exists.  Is there a reason for this?  The
> attached patch re-enables the driver.

I don't remember any reason, no test box perhaps ?

The patch looks fine

regards,
Phil
