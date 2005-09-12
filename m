Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVILCKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVILCKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 22:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVILCKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 22:10:20 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:49316 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1751131AbVILCKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 22:10:19 -0400
X-ORBL: [67.124.117.85]
Date: Sun, 11 Sep 2005 19:09:59 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, ak@suse.de, torvalds@osdl.org,
       Greg Edwards <edwardsg@sgi.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [2/3] Set compatibility flag for 4GB zone on IA64
Message-ID: <20050912020959.GB15881@taniwha.stupidest.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E72@scsmsx401.amr.corp.intel.com> <4324BCBB.90407@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4324BCBB.90407@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 07:24:43PM -0400, Jeff Garzik wrote:

> SGI machines support random PCI cards, right?

Technically the hardware does but I doubt SGI will help you if your
ne2k doesn't work.

> If so, you cannot presume I/O devices have no 32-bit limits.

The IO busses have IOMMUs on them anyhow.
