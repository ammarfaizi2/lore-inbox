Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992702AbWKASNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992702AbWKASNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992701AbWKASNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:13:31 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:64914 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1946950AbWKASNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:13:30 -0500
Date: Wed, 1 Nov 2006 20:12:37 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Message-ID: <20061101181237.GA8933@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <200611011825.47710.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611011825.47710.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Andi Kleen <ak@suse.de>:
> Subject: Re: 2.6.19-rc <-> ThinkPads
> 
> 
> > I suspect reverting it is the right thing to do - the patch only 
> > introduces bugs, an doesn't actually _fix_ anything, it just "cleans 
> > things up".
> 
> Ok please revert the i386 patch for now then if it fixes the ThinkPads. 
> The x86-64 version should be probably fixed too, but doesn't cleanly. I will 
> send you later a patch to fix this there properly.

Could you sent the patch so I can test it, pls?
git revert creates conflicts.

-- 
MST
