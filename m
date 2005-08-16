Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVHPFfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVHPFfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVHPFfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:35:48 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:36808 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S965113AbVHPFfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:35:47 -0400
X-ORBL: [63.205.185.3]
Date: Mon, 15 Aug 2005 22:35:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Michael E Brown <Michael_E_Brown@dell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Doug Warzecha <Douglas_Warzecha@dell.com>
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050816053541.GA26150@taniwha.stupidest.org>
References: <1124169589.10755.194.camel@soltek.michaels-house.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124169589.10755.194.camel@soltek.michaels-house.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 12:19:49AM -0500, Michael E Brown wrote:

> Hmm... did I mention libsmbios? :-)
> http://linux.dell.com/libsmbios/main.

I'm aware of it --- it seems pretty limited right now and I'm still
irked Dell isn't more forthcoming with documentation.

> SMI support is not yet implemented inside libsmbios, but I am
> working feverishly on it (in-between emails to linux-kernel, of
> course.) :-) We have a development mailing list, and I will make the
> announcement there when it has been complete.

[...]

> I cannot (at this point, I'm working on it, though), provide our
> internal documentation of our SMI implementation directly. But, I am
> authorized to add all of this to libsmbios, and I intend to very
> clearly document all of the SMI calls in libsmbios.

Given that why not resubmit the kernel driver when the userspace
becomes usable for people without them having to use MonsterApp from
Dell?

> Aside from that, for the most part, the only thing SMI ever does is
> pass buffers back and forth.

I meant to ask; does this have horrible latency or nasties like lots
of laptop SMM stuff?
