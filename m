Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVJETPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVJETPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVJETPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:15:36 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:56502 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932526AbVJETPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:15:35 -0400
Date: Wed, 5 Oct 2005 15:15:34 -0400
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: AMD Geode GX/LX support V2
Message-ID: <20051005191534.GF8011@csclub.uwaterloo.ca>
References: <20051005164626.GA25189@cosmic.amd.com> <20051005165405.GB25189@cosmic.amd.com> <20051005182947.GE8011@csclub.uwaterloo.ca> <20051005192711.GC1548@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005192711.GC1548@cosmic.amd.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 01:27:11PM -0600, Jordan Crouse wrote:
> if anything it would be the GEODEGX1 option, but i486 would work just as 
> well.

Well I may switch to the GX1 setting later when it actually appears in
the kernel.

> No - the SC1200 and GX1 use the cs5530 companion chip which has a different
> IDE engine then the CS5535.

So the SC1200 is a GX1 and CS5530 in one chip then (given the SC1200
doesn't need a companion chip)?  Currently I use the SC1200 ide driver.
So far no DMA, but that could be because I use compact flash on the ide
connector.  The card claims to support DMA though as far as I can tell.
or is the SCx200 using it's own ide system?

Len Sorensen
