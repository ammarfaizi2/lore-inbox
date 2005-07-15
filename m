Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263203AbVGOEe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbVGOEe3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 00:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbVGOEe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 00:34:29 -0400
Received: from graphe.net ([209.204.138.32]:35493 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263203AbVGOEe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 00:34:27 -0400
Date: Thu, 14 Jul 2005 21:34:26 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: David Gibson <david@gibson.dropbear.id.au>
cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: RFC: Hugepage COW
In-Reply-To: <20050715042146.GE7750@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0507142133330.23933@graphe.net>
References: <20050707055554.GC11246@localhost.localdomain>
 <Pine.LNX.4.62.0507141022440.14347@graphe.net> <20050715011428.GC7750@localhost.localdomain>
 <Pine.LNX.4.62.0507141858220.21873@graphe.net> <20050715042146.GE7750@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, David Gibson wrote:

> I'm still not at all sure what you're getting at.  Do you mean the
> demand-allocation patches which were floating around at some point - I
> gather they're important for doing sensible NUMA allocation of
> hugepages.  They have a small overlap with the COW code, in the fault
> handler, but not much.

Yes I meant that. I do not have time right now but I will be trying to 
contribute to this if things slow down a bit. Keep me posted.


