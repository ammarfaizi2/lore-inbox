Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVLFN0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVLFN0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVLFN0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:26:20 -0500
Received: from gate.in-addr.de ([212.8.193.158]:49281 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932556AbVLFN0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:26:19 -0500
Date: Tue, 6 Dec 2005 14:25:59 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206132559.GV21914@marowsky-bree.de>
References: <20051203135608.GJ31395@stusta.de> <43949541.9060700@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43949541.9060700@tmr.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-12-05T14:30:09, Bill Davidsen <davidsen@tmr.com> wrote:

> Actually I would be happy with the stability of this series if people 
> would stop trying to take working features OUT of it!

Features are removed when they are no longer features, but design
irritations in a new and improved design, and usually, equivalent or
better (or at least thought to be) functionality is available still in
the big picture (which includes user-space), hopefully in a cleaner
place.

Now, design is often a holy war, and people disagree. That's fine and to
be expected. And sometimes, the whole solution takes a while to
materialize and be implemented from the kernel up to all user-space and
even longer until it has been implemented in the brains of the admins.
This, too, is fine and expected. It's called "innovation" and
"development", sometimes iterative.

> working all that well in any case. But if existing features suddenly 
> drop out from beneath the user, then you will find people doing what you 
> mentioned, staying with old kernels with holes rather than moving to 
> kernels which are simply no longer functional.

You're assuming the kernel is both "static" design-wise as well as
independent (or at least basically eternally backwards compatible) from
user-space. Both assumptions are no longer true. Get over it.


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

