Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRB1X1p>; Wed, 28 Feb 2001 18:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129364AbRB1X1g>; Wed, 28 Feb 2001 18:27:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20615 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129363AbRB1X1W>;
	Wed, 28 Feb 2001 18:27:22 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15005.34953.909874.589120@pizda.ninka.net>
Date: Wed, 28 Feb 2001 15:23:53 -0800 (PST)
To: Zach Brown <zab@zabbo.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_dma_set_mask()
In-Reply-To: <20010228161450.A25553@tetsuo.zabbo.net>
In-Reply-To: <20010228103727.I23735@tetsuo.zabbo.net>
	<3A9D26A2.14563DE1@mandrakesoft.com>
	<20010228161450.A25553@tetsuo.zabbo.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zach Brown writes:
 > > extremely minor nit that I think pci_set_dma_mask should return ENODEV
 > > or EIO or something on error, and zero on success.
 > 
 > I agree, though I'd like to leave the decision up to people who live and
 > breathe this stuff.
 > 
 > please feel free to make minor adjustments and submit :)

Jeff/Zach, I agree, I'm fully for such a patch, but please update the
documentation!  It is the most important part of the patch.

Later,
David S. Miller
davem@redhat.com
