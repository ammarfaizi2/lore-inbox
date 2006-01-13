Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422861AbWAMTix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWAMTix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422862AbWAMTix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:38:53 -0500
Received: from c-67-174-241-67.hsd1.ca.comcast.net ([67.174.241.67]:63935 "EHLO
	plato.virtuousgeek.org") by vger.kernel.org with ESMTP
	id S1422861AbWAMTiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:38:52 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/15] pci: Add Toshiba PSA40U laptop to ohci1394 quirk dmi table.
Date: Fri, 13 Jan 2006 11:38:42 -0800
User-Agent: KMail/1.9
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
References: <0ISL00NV994G1L@a34-mta01.direcway.com> <20060111051532.GA3455@kroah.com>
In-Reply-To: <20060111051532.GA3455@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131138.43301.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 10, 2006 9:15 pm, Greg KH wrote:
> On Wed, Jan 04, 2006 at 04:59:59PM -0500, Ben Collins wrote:
> > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> >
> > ---
> >
> >  arch/i386/pci/fixup.c |    7 +++++++
>
> Hm, you might want to cc: the maintainers of the sections you are
> patching to make sure they see the change you are making.
>
> Care to respin this against the latest -git tree and resend it to me?

Didn't I already submit this patch?  (Checks...)  Yes, I did, and it's 
already in the tree:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=19272684b8e2fff39941e4c044d26ad349dd1a69

Ben, did you get it from me or was it submitted to you separately?  Just 
curious because I wasn't in the signed-off-by line...  Anyway, it should 
work for you now hopefully.

Jesse
