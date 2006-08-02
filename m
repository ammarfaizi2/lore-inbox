Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWHBXXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWHBXXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWHBXXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:23:17 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:37315 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932226AbWHBXXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:23:16 -0400
Date: Thu, 3 Aug 2006 02:23:13 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 0 of 4] x8-64: Calgary: updates for CONFIG_IOMMU_DEBUG
Message-ID: <20060802232313.GF4982@rhun.ibm.com>
References: <patchbomb.1154559547@rhun.haifa.ibm.com> <200608030116.48607.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608030116.48607.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 01:16:48AM +0200, Andi Kleen wrote:
> On Thursday 03 August 2006 00:59, Muli Ben-Yehuda wrote:
> > Hi Andi,
> > 
> > A few Calgary updates for CONFIG_IOMMU_DEBUG: print a message when
> > CONFIG_IOMMU_DEBUG is on, remove dangerous bringup debugging code and
> > only double check our bitmap handling if currently debugging.
> > 
> > Please apply, patches are againt mainline with all previous Calgary
> > patches applied (which should apply cleanly to your tree).
> 
> Added thanks.
> 
> In the future please be a little bit more verbose in the changelog
> department.

The patches themselves have verbose changelog entries, I never know
quite what to write in the introductory message - I guess I'll just
hack mercurial's email extension to get rid of it (unless it's useful
to you?)

Cheers,
Muli
