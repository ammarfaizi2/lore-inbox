Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUIVXRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUIVXRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUIVXRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:17:10 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:25999 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268108AbUIVXRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:17:01 -0400
Date: Thu, 23 Sep 2004 01:17:00 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
Message-ID: <20040922231700.GE30109@MAIL.13thfloor.at>
Mail-Followup-To: Linas Vepstas <linas@austin.ibm.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	paulus@samba.org, linux-kernel@vger.kernel.org, anton@samba.org,
	Andrew Morton <akpm@osdl.org>
References: <20040920221933.GB1872@austin.ibm.com> <20040920223121.GC1872@austin.ibm.com> <200409211407.09764.vda@port.imtp.ilyichevsk.odessa.ua> <20040921161216.GD1872@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921161216.GD1872@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 11:12:16AM -0500, Linas Vepstas wrote:
> On Tue, Sep 21, 2004 at 02:07:09PM +0300, Denis Vlasenko was heard to remark:
> > On Tuesday 21 September 2004 01:31, Linas Vepstas wrote:
> > > 
> > > Forgot to attach the actual patch.
> > > 
> > > On Mon, Sep 20, 2004 at 05:19:33PM -0500, Linas Vepstas was heard to remark:
> > > > Hi,
> > > 
> > > 
> > > This file mixes tabs with 8 spaces, leading to poor display 
> > > if one's editor doesn't have tab-stops set to 8.   Please apply.
> > 
> > There are lots of such places.
> > Automated scripts can easily produce megabytes worth of whitespace
> > patches.
> > 
> > As I understand, such patches aren't accepted because
> > merging pain is much greater than gain.
> > Typically whitespace cleanups are piggybacked on some code changes.
> 
> Last time I sent in a combined whitespace plus other-fixes patch, 
> I was asked to do the opposite, and split them apart.  I'm just
> trying to do the right thing; I have other pending patches for this 
> file, and I'm waiting for the backlog to clear out before I submit
> those.

well, I'd like to know if full whitespace cleanup
(trailing and indentation) _is_ something which
is interesting for linux mainline ...

because if so, I probably could provide a bunch of
patches too ... 

TIA,
Herbert

> --linas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
