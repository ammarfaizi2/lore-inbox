Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWG3NBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWG3NBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWG3NBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:01:25 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:47565 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932309AbWG3NBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:01:24 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jan Dittmer <jdi@l4x.org>, Pavel Machek <pavel@suse.cz>,
       Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <20060730114722.GA26046@srcf.ucam.org>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <20060730112827.GA25540@srcf.ucam.org> <44CC993B.6070309@l4x.org>
	 <20060730114722.GA26046@srcf.ucam.org>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 15:01:17 +0200
Message-Id: <1154264478.13635.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 12:47 +0100, Matthew Garrett wrote:
> On Sun, Jul 30, 2006 at 01:34:19PM +0200, Jan Dittmer wrote:
> 
> > Why not get rid of the daemon like bsd did [0]? Otherwise in
> > 5 years you'll have 42 daemons running which communicate with
> > the firmware of various devices, each having a different inter-
> > face.
> 
> Because it would involve a moderate rewriting of the driver, and we'd 
> have to carry a delta against Intel's code forever.
without knowing this for sure, dont you think that if a largely changed
version of the driver appeared in the tree, intel may start developing
on that? cause then they wouldnt be the ones that "broke" compliance
with FCC(hah) by not doing binaryonly.
> 

