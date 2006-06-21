Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWFUBHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWFUBHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWFUBHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:07:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23528 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751909AbWFUBHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:07:45 -0400
Date: Tue, 20 Jun 2006 18:07:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, npiggin@suse.de, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 0/3] 2.6.17 radix-tree: updates and lockless
In-Reply-To: <1150850849.12507.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606201806350.14643@schroedinger.engr.sgi.com>
References: <20060408134635.22479.79269.sendpatchset@linux.site> 
 <20060620153555.0bd61e7b.akpm@osdl.org>  <1150844989.1901.52.camel@localhost.localdomain>
  <20060620163037.6ff2c8e7.akpm@osdl.org>  <1150847428.1901.60.camel@localhost.localdomain>
  <Pine.LNX.4.64.0606201732580.14331@schroedinger.engr.sgi.com>
 <1150850849.12507.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:

> No, our hardware interrupt numbers are an encoded form containing the
> geographical location of the device :) so they are 24 bits at least (and
> we have a platform coming where they can be 64 bits).

PICs with build in GPSses? And I thought we had weird hardware....

