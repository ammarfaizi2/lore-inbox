Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWFQQ1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWFQQ1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 12:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWFQQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 12:27:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7558 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750706AbWFQQ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 12:27:44 -0400
Date: Sat, 17 Jun 2006 09:27:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: christoph@lameter.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] slab: consolidate allocation paths
In-Reply-To: <84144f020606162144tbd14081tdaae00a8e4af9c7f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606170927140.18882@schroedinger.engr.sgi.com>
References: <1150355565.4633.8.camel@ubuntu> 
 <Pine.LNX.4.64.0606161304400.16488@schroedinger.engr.sgi.com>
 <84144f020606162144tbd14081tdaae00a8e4af9c7f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006, Pekka Enberg wrote:

> On 6/16/06, Christoph Lameter <clameter@sgi.com> wrote:
> > Which kernel does this apply to? Cannot find this in upstream nor in
> > Andrews tree.
> 
> Applies on top of git head and 2.6.17-rc6 from www.kernel.org here.
> Did you apply both patches?

Got them in wrong order it seems.

