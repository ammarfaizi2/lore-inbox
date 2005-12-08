Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVLHVKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVLHVKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVLHVKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:10:53 -0500
Received: from ns.suse.de ([195.135.220.2]:684 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932388AbVLHVKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:10:51 -0500
Date: Thu, 8 Dec 2005 22:10:50 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       steiner@sgi.com, linux-kernel@vger.kernel.org,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 3/3] Zone reclaim V3: Frequency of failed reclaim attempts
Message-ID: <20051208211049.GT11190@wotan.suse.de>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com> <20051208203717.30456.17434.sendpatchset@schroedinger.engr.sgi.com> <20051208205241.GR11190@wotan.suse.de> <Pine.LNX.4.62.0512081308360.30567@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512081308360.30567@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 01:08:50PM -0800, Christoph Lameter wrote:
> Patch:

Looks good thanks.

I hope this will help Opteron users a lot who have been always
complaining about this too.

-Andi

