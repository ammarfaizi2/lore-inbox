Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWBDPLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWBDPLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 10:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWBDPLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 10:11:17 -0500
Received: from graphe.net ([209.204.138.32]:2216 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932505AbWBDPLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 10:11:16 -0500
Date: Sat, 4 Feb 2006 07:11:12 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, manfred@colorfullife.com,
       pj@sgi.com
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
In-Reply-To: <1139060024.8707.5.camel@localhost>
Message-ID: <Pine.LNX.4.62.0602040709210.31909@graphe.net>
References: <1139060024.8707.5.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Pekka Enberg wrote:

> I don't have access to NUMA machine and would appreciate if someone
> could give this patch a spin and let me know I didn't break anything.

No time to do a full review (off to traffic school... sigh), I did not 
see anything by just glancing over it but the patch will conflict with 
Paul Jacksons patchset to implement memory spreading.
