Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVLOSrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVLOSrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVLOSrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:47:48 -0500
Received: from petaflop.b.gz.ru ([217.67.124.5]:6591 "EHLO hq.sectorb.msk.ru")
	by vger.kernel.org with ESMTP id S1750910AbVLOSrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:47:47 -0500
Date: Thu, 15 Dec 2005 21:47:43 +0300
From: "Alexander V. Inyukhin" <shurick@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Subject: Support for Digi Neo 8p board in jsm driver
Message-ID: <20051215184743.GA8358@shurick.s2s.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jsm driver is claimed to support Digi Neo multiport
serial boards but according to PCI id table
only 2port boards are supported.

Is it possible to support other Digi Neo boards by jsm
or original dgnc driver should be used instead?

Kconfig referred to Documentation/jsm.txt file
but it is not provided.

Please CC me.
