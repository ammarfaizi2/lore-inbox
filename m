Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWBMXQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWBMXQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWBMXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:16:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44672 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030267AbWBMXQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:16:55 -0500
Date: Tue, 14 Feb 2006 10:16:45 +1100
From: Nathan Scott <nathans@sgi.com>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any FS with tree-based quota system?
Message-ID: <20060214101645.H9257106@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu> <20060214083353.A9257106@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0602131505080.330@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.64.0602131505080.330@potato.cts.ucla.edu>; from cbs@cts.ucla.edu on Mon, Feb 13, 2006 at 03:11:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 03:11:12PM -0800, Chris Stromsoe wrote:
> On Tue, 14 Feb 2006, Nathan Scott wrote:
> > On Mon, Feb 13, 2006 at 11:03:35AM -0800, Chris Stromsoe wrote:
> >> I'm looking for a file system with a tree-based quota system.  XFS on 
> >> IRIX has projects, but that functionality didn't get ported over to 
> >> Linux that I can see.
> >
> > You didn't look very closely then. ;)
> 
> This is from a Debian stable machine,

Well, yeah - thats ye olde worlde code.

> with xfsprogs 2.6.20. :)  I'm more 
> than happy to be proven wrong.
> 
> cbs:/usr/share/doc/xfsprogs > zcat README.quota.gz | tail -13

Things have moved on since then - a more recent xfsprogs has an
xfs_quota(8) man page which will be of use to you here.

cheers.

-- 
Nathan
