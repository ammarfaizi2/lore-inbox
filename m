Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVAXXXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVAXXXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVAXXXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:23:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6593 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261689AbVAXXTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:19:03 -0500
Date: Mon, 24 Jan 2005 17:32:30 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: Andres Salomon <dilinger@voxel.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-as1 / 2.4 security-only patchset?
Message-ID: <20050124193230.GB15501@logos.cnet>
References: <1105605448.7316.13.camel@localhost> <20050124171011.GW16286@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050124171011.GW16286@edu.joroinen.fi>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 07:10:11PM +0200, Pasi Kärkkäinen wrote:
> On Thu, Jan 13, 2005 at 03:37:28AM -0500, Andres Salomon wrote:
> > Hi,
> > 
> > I'm announcing a new kernel tree; -as.  The goal of this tree is to form
> > a stable base for vendors/distributors to use for their kernels.  In
> > order to do this, I intend to include only security fixes and obvious
> > bugfixes, from various sources.  I do not intend to include driver
> > updates, large subsystem fixes, cleanups, and so on.  Basically, this is
> > what I'd want 2.6.10.1 to contain.
> > 
> 
> Hi!
> 
> This is good!
> 
> Is anybody doing the same for 2.4 kernel series? Only security-fixes for vanilla
> 2.4 kernels.. that would be nice too. 

Nope, nobody has done that for v2.4 kernels. 

Security fixes are included in v2.4-pre which is later shipped as v2.4.x final.

If someone is willing to maintain a list of the upcomming security updates I'm more than
happy to cooperate.


