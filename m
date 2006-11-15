Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162022AbWKOWmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162022AbWKOWmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162024AbWKOWmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:42:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:26820 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1162022AbWKOWmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:42:13 -0500
Date: Wed, 15 Nov 2006 14:41:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <455B8F3A.6030503@mbligh.org>
Message-ID: <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
 <455B8F3A.6030503@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Martin Bligh wrote:

> A node is an arbitrary container object containing one or more of:
> 
> CPUs
> Memory
> IO bus
> 
> It does not have to contain memory.

I have never seen a node on Linux without memory. I have seen nodes 
without processors and without I/O but not without memory.This seems to be 
something new?

