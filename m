Return-Path: <linux-kernel-owner+w=401wt.eu-S1425536AbWLHSEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425536AbWLHSEY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425584AbWLHSEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:04:24 -0500
Received: from cantor.suse.de ([195.135.220.2]:41671 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425536AbWLHSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:04:23 -0500
Date: Fri, 8 Dec 2006 10:04:08 -0800
From: Greg KH <gregkh@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dtor@insightbb.com>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input patches for 2.6.19
Message-ID: <20061208180408.GA27288@suse.de>
References: <200612080157.04822.dtor@insightbb.com> <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz> <1165579184.5529.33.camel@aeonflux.holtmann.net> <20061208030755.4ae3d5df.akpm@osdl.org> <Pine.LNX.4.64.0612081248210.4215@jikos.suse.cz> <1165583203.29922.0.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165583203.29922.0.camel@aeonflux.holtmann.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 02:06:42PM +0100, Marcel Holtmann wrote:
> Hi Jiri,
> 
> > > > > Greg, should I prepare a new version of the generic HID patches against 
> > > > > merged Linus' + Dmitry's trees and send them to you?
> > > > yes please, because Linus already merged Dmitry's patches.
> > > I suggest that you leave it for 12 hours - there's a lot more stuff in flight and
> > > there might be overlaps.
> > 
> > OK. Could you please let me know when all these are merged? I have already 
> > rebased all the patches against current Linus' tree (with Dmitry's tree 
> > merged), but will hold on until I get green light from you, and then send 
> > this again to Greg - Greg, is that fine by you?
> 
> if you already rebased everything. Then lets merge now. Once this is out
> of the way everything else will be much more simple.

Ok, am taking Jiri's patches and will push to Linus in a bit when I
respin them and test again.

thanks,

greg k-h
