Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161461AbWASWnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161461AbWASWnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161462AbWASWnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:43:04 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:36737
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161461AbWASWnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:43:03 -0500
Date: Thu, 19 Jan 2006 14:43:02 -0800
From: Greg KH <greg@kroah.com>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-git9] aoe [1/8]: zero packet data after skb allocation
Message-ID: <20060119224302.GA27679@kroah.com>
References: <1d5bd928255f552b12b1b329c92257bb@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d5bd928255f552b12b1b329c92257bb@coraid.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 12:37:24PM -0500, Ed L. Cashin wrote:
> These eight patches supercede the seven aoe patches sent on January
> third for the 2.6.15-rc7 kernel.  A bug existed in the Jan. 3 set of
> patches where the retransmit timer for an AoE device AoE timer could
> be added twice.  That bug has been fixed in this set of patches.

Ok, now I got them all, sorry about that, slow email system here...

greg k-h
