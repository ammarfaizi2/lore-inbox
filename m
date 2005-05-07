Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263061AbVEGMRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbVEGMRY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 08:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbVEGMRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 08:17:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58633 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263061AbVEGMRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 08:17:21 -0400
Date: Sat, 7 May 2005 14:08:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, openafs-info@openafs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Message-ID: <20050507120821.GA18710@alpha.home.local>
References: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr> <20050506052803.GE777@alpha.home.local> <20050506165033.GA2105@logos.cnet> <Pine.LNX.4.62.0505071245500.7641@tassadar.physics.auth.gr> <20050507100926.GA18418@alpha.home.local> <Pine.LNX.4.62.0505071449430.9934@tassadar.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505071449430.9934@tassadar.physics.auth.gr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 02:51:12PM +0300, Dimitris Zilaskos wrote:
> 
> >
> >please try 2.4.30 with openafs 1.3.78 (I don't know if the patch applies
> >cleanly). It will help determining which of kernel and openafs upgrades
> >bring the problem.
> 
> 
> 	Hi Willy ,
> 
> Which path are you referring to ? I plan to use a fresh 2.4.30 
> compilation.

Sorry, I believed openafs was provided as a patch against the kernel
while it is not. So there's no problem building 1.3.78 on top of 2.4.30.

Regards,
Willy

