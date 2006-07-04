Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWGDFxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWGDFxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGDFxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:53:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28088 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751158AbWGDFxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:53:14 -0400
Date: Mon, 3 Jul 2006 22:53:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com,
       kernel@kolivas.org, marcelo@kvack.org, nickpiggin@yahoo.com.au,
       ak@suse.de
Subject: Re: [RFC 8/8] Fix i386 SRAT check for MAX_NR_ZONES
In-Reply-To: <20060704145213.75cc5cf5.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0607032252480.10856@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
 <20060703215616.7566.56782.sendpatchset@schroedinger.engr.sgi.com>
 <20060704145213.75cc5cf5.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006, KAMEZAWA Hiroyuki wrote:

> This patch is same to 
> [RFC 5/8] swap_prefetch: Make use of ZONE_HIGHMEM dependend on CONFIG_HIGHMEM
> 
> please check. I think what you intended was patch against chunk_to_zones().

Right. Wrong filename.

