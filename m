Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUFDMpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUFDMpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUFDMpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:45:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265775AbUFDMpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:45:40 -0400
Date: Fri, 4 Jun 2004 09:46:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: Linux 2.4.27-pre5
Message-ID: <20040604124636.GA18461@logos.cnet>
References: <20040603022432.GA6039@logos.cnet> <20040604083849.GA6493@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604083849.GA6493@merlin.emma.line.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 10:38:49AM +0200, Matthias Andree wrote:
> On Wed, 02 Jun 2004, Marcelo Tosatti wrote:
> 
> > Here goes -pre5.
> > 
> > This time we have merges from Jeff's -netdrivers tree, David's -net tree, 
> > including a fix for compilation error without CONFIG_SCTP set, SPARC64 update,
> > i810_audio fixes, amongst others.
> > 
> > 
> > Summary of changes from v2.4.27-pre4 to v2.4.27-pre5
> > ============================================
> > 
> > <chrisg:etnus.com>:
> > <kevin.curtis:farsite.co.uk>:
> > <pelle:dsv.su.se>:
> 
> Marcelo,
> 
> can you try to remember to "bk pull http://bktools.bkbits.net/bktools"
> and "bk get shortlog" before sending out kernel changelogs? This will
> resolve, for instance, all of the addresses in this particular
> announcement to names.
> 
> BTW, if you forgot but haven't yet sent the announcement, perl shortlog
> --mode=fixup will replace the addresses it knows (but it will not
> re-sort the items).

Matthias,

Ok, will do so.

Thanks.
