Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUIWAaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUIWAaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUIWAaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:30:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27524 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265211AbUIWA36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:29:58 -0400
Date: Wed, 22 Sep 2004 19:29:42 -0500
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
Message-ID: <20040923002942.GB18954@austin.ibm.com>
References: <20040920221933.GB1872@austin.ibm.com> <20040920223121.GC1872@austin.ibm.com> <200409211407.09764.vda@port.imtp.ilyichevsk.odessa.ua> <20040921161216.GD1872@austin.ibm.com> <20040922231700.GE30109@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922231700.GE30109@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 01:17:00AM +0200, Herbert Poetzl was heard to remark:
> On Tue, Sep 21, 2004 at 11:12:16AM -0500, Linas Vepstas wrote:
> > On Tue, Sep 21, 2004 at 02:07:09PM +0300, Denis Vlasenko was heard to remark:
> > > On Tuesday 21 September 2004 01:31, Linas Vepstas wrote:
> > > > 
> > > > Forgot to attach the actual patch.
> > > > 
> > > > On Mon, Sep 20, 2004 at 05:19:33PM -0500, Linas Vepstas was heard to remark:
> > > > > Hi,
> > > > 
> > > > 
> > > > This file mixes tabs with 8 spaces, leading to poor display 
> > > > if one's editor doesn't have tab-stops set to 8.   Please apply.
> > > 
> > > There are lots of such places.
> > > Automated scripts can easily produce megabytes worth of whitespace
> > > patches.
> > > 
> > > As I understand, such patches aren't accepted because
> > > merging pain is much greater than gain.
> > > Typically whitespace cleanups are piggybacked on some code changes.
> > 
> > Last time I sent in a combined whitespace plus other-fixes patch, 
> > I was asked to do the opposite, and split them apart.  I'm just
> > trying to do the right thing; I have other pending patches for this 
> > file, and I'm waiting for the backlog to clear out before I submit
> > those.
> 
> well, I'd like to know if full whitespace cleanup
> (trailing and indentation) _is_ something which
> is interesting for linux mainline ...
> 
> because if so, I probably could provide a bunch of
> patches too ... 

Hey, don't wreck it for me; I want this applied because I actually 
read this file every couple of days.  No need to clean up any files 
that *I* don't read...

--linas
