Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTEOAwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263383AbTEOAwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:52:33 -0400
Received: from dp.samba.org ([66.70.73.150]:2013 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263373AbTEOAwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:52:31 -0400
Date: Thu, 15 May 2003 11:04:59 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Andrew Morton <akpm@digeo.com>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, breed@almaden.ibm.com, achirica@ttd.net,
       jkmaline@cc.hut.fi
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515010459.GC23670@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Andrew Morton <akpm@digeo.com>, jt@hpl.hp.com, jt@bougret.hpl.hp.com,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	breed@almaden.ibm.com, achirica@ttd.net, jkmaline@cc.hut.fi
References: <20030514233235.GA11581@bougret.hpl.hp.com> <20030514163826.6459cd93.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514163826.6459cd93.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 04:38:26PM -0700, Andrew Morton wrote:
> Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
> >
> > firmwares blobs 
> 
> well for the purposes of tracking 2.6 activities I'll separate this issue
> of firmware access policy out from drivers/net/wireless/. 
> 
> yeah, it would be nice if the core kernel provided a "give me my firmware"
> API or something.

Well, Manuel Estrada (also author of the orinoco USB patches) has
proposed one on lkml.  Doesn't look like people were happy with that
version, but I think he's still working on revising it based on
feedback.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
