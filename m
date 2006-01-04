Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWADH3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWADH3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWADH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:29:04 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:64690 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751198AbWADH3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:29:03 -0500
Date: Wed, 4 Jan 2006 09:28:51 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com
Subject: Re: [patch 0/9] slab cleanups
In-Reply-To: <20060103175723.5d3c1856.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601040925230.1798@sbz-30.cs.Helsinki.FI>
References: <1136319929.8629.15.camel@localhost> <20060103175723.5d3c1856.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> >  Here's some pending slab cleanup patches from various people. Please note
> >  that the patch "slab: distinguish between object and buffer size" is a
> >  replacement for the objsize renaming patch you have sitting in -mm.

On Tue, 3 Jan 2006, Andrew Morton wrote: 
> [ 21 out of 33 hunks FAILED -- saving rejects to file mm/slab.c.rej ]
> I'd prefer to not apply any of this for now - there are plenty of slab
> patches queued already and now is not the time to be churning things with
> cleanups.  If you have actual functional improvements or bugfixes then
> please separate those out and send.  Otherwise, please save this lot for a
> few weeks hence when the current batch of stuff is merged up, thanks.

The series has nothing that can't wait for few weeks. Please don't merge 
the "objsize renaming" patch you have because we have a better one for 
that. Thanks.

			Pekka
