Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUA1Uqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUA1Uqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:46:31 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:7047 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S266007AbUA1Uqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:46:30 -0500
Date: Wed, 28 Jan 2004 12:46:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Antony Suter <suterant@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040128204611.GD2445@srv-lnx2600.matchmail.com>
Mail-Followup-To: Antony Suter <suterant@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1075302403.10057.5.camel@hikaru.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075302403.10057.5.camel@hikaru.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 02:06:43AM +1100, Antony Suter wrote:
> On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
> > If anyone has any more external trees which need similar treatment,
> > please let me know.
> > 
> 
> The WLI patchset. It has a small number of good improvements for NUMA
> machines and notebooks. A couple of the patches have already made it
> into the kernel.

Isn't that a bit much?  The wli tree makes changes across the entire tree,
so it isn't very localized to any specific subsystem.

Though specific cleanups would be good to merge into -mm from -wli...
