Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFBOoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFBOoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFBOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:44:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:23522 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261153AbVFBOmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:42:47 -0400
Date: Thu, 2 Jun 2005 07:52:51 -0700
From: Greg KH <greg@kroah.com>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] eCryptfs: eCryptfs kernel module
Message-ID: <20050602145251.GB12565@kroah.com>
References: <20050602054740.GA4514@sshock.rn.byu.edu> <20050602073303.GA9373@kroah.com> <20050602122807.GA8855@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602122807.GA8855@halcrow.us>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 07:28:07AM -0500, Michael Halcrow wrote:
> On Thu, Jun 02, 2005 at 12:33:03AM -0700, Greg KH wrote:
> > Why not fix up the stuff that you know needs to be fixed?  It should
> > not be merged until then at the least.
> 
> We'll keep plugging away; note that all this could take several months
> (there are currently about 160 TODO items in the code base, plus
> several more features to flesh out), and in the meantime, we would
> like some general commentary from the community so we don't wind up
> pouring time and effort in the wrong direction.

That's fine, but you asked for it to be accepted now, and yet you
pointed out major issues remaining.  You can see how I would be confused
:)

thanks,

greg k-h
