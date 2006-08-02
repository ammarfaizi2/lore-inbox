Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWHBFTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWHBFTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWHBFTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:19:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10391 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751229AbWHBFTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:19:24 -0400
Date: Tue, 1 Aug 2006 22:18:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Gerd Hoffmann <kraxel@suse.de>, Hollis Blanchard <hollisb@us.ibm.com>,
       Ian Pratt <ian.pratt@xensource.com>, Zachary Amsden <zach@vmware.com>,
       npiggin@suse.de, Ian Wienand <ianw@gelato.unsw.edu.au>
Subject: Re: [PATCH 1 of 13] Add apply_to_page_range() which applies a function
 to a pte range
In-Reply-To: <1154492211.2570.43.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608012214440.21242@schroedinger.engr.sgi.com>
References: <79a98a10911fc4e77dce.1154421372@ezr.goop.org> 
 <m1ejw0zmic.fsf@ebiederm.dsl.xmission.com>  <20060801211410.GH2654@sequoia.sous-sol.org>
  <Pine.LNX.4.64.0608011421080.19146@schroedinger.engr.sgi.com>
 <1154492211.2570.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006, Rusty Russell wrote:

> 	Thanks for the pointers, but as you've been debating for 18 months now,
> no patches are in the -mm tree or obviously about to go in, and this new
> helper function is orthogonal to your work, I don't think it's
> reasonable to delay this patch.

I have not been involved in this issue for a long time now.
You need to contact the people actively working on code like this. 
Most important is likely Ian Wienand. 

