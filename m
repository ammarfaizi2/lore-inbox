Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTFEVxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbTFEVxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:53:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38208 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264880AbTFEVxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:53:36 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306052207.h55M74Q26865@devserv.devel.redhat.com>
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
To: hugo-lkml@carfax.org.uk (Hugo Mills)
Date: Thu, 5 Jun 2003 18:07:04 -0400 (EDT)
Cc: sflory@rackable.com (Samuel Flory), hugo-lkml@carfax.org.uk (Hugo Mills),
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andre@linux-ide.org, alan@redhat.com
In-Reply-To: <20030605211526.GE1542@carfax.org.uk> from "Hugo Mills" at Meh 05, 2003 10:15:26 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> just couldn't find _any_ other SiI3112 SATA card on the market in this
> country. I don't run Red Hat or SuSE, and particularly not their
> kernels -- (I normally run Alan's kernels). Does this mean that I've
> bought a pig in a poke?

If its a standard SI3112 series device with a different device ID then it
ought to work just by adding the ids to the driver.
