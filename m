Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRK1Sor>; Wed, 28 Nov 2001 13:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRK1Sog>; Wed, 28 Nov 2001 13:44:36 -0500
Received: from hermes.toad.net ([162.33.130.251]:49360 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S279105AbRK1So2>;
	Wed, 28 Nov 2001 13:44:28 -0500
Subject: PnP BIOS driver -- Can it go in?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E1697I9-0005IQ-00@the-village.bc.nu>
In-Reply-To: <E1697I9-0005IQ-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 13:45:11 -0500
Message-Id: <1006973117.11751.15.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 11:10, Alan Cox wrote:
> Submit it to Linus.

Linus and Marcelo: Would either of you accept a patch to add
the pnpbios driver with /proc interface, so we can use lspnp
and setpnp to control how PnP BIOS configures devices?

This driver was in 2.4.x-acy for quite a long time and I
believe that the basic functionality was pretty well
debugged and tested.

Thomas Hood


