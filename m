Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWKEFqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWKEFqd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 00:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWKEFqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 00:46:33 -0500
Received: from mx1.suse.de ([195.135.220.2]:23433 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161032AbWKEFqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 00:46:32 -0500
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs =?iso-8859-15?q?for=09paravirtualizing_critical?= operations
Date: Sun, 5 Nov 2006 06:46:15 +0100
User-Agent: KMail/1.9.5
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20061029024504.760769000@sous-sol.org> <200611032209.40235.ak@suse.de> <1162701815.29777.6.camel@localhost.localdomain>
In-Reply-To: <1162701815.29777.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611050646.15334.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andi, the patches work against Andrew's tree, and he's merged them in
> rc4-mm2.  There are a few warnings to clean up, but it seems basically
> sound.
> 
> At this point I our think time is better spent on beating those patches
> up, rather than going back and figuring out why they don't work in your
> tree.

My tree is basically mainline as base. Sure if you don't care about mainline
merges we can ignore it there and keep it forever in -mm* until Andrew
gets tired of it?

That's a possible strategy, but only if you want to keep it as a mm-only
toy forever.

-Andi
