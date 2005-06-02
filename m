Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVFBMaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFBMaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVFBMaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:30:25 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:38876 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261392AbVFBMaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:30:20 -0400
X-ORBL: [69.150.57.195]
Date: Thu, 2 Jun 2005 07:28:07 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] eCryptfs: eCryptfs kernel module
Message-ID: <20050602122807.GA8855@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050602054740.GA4514@sshock.rn.byu.edu> <20050602073303.GA9373@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602073303.GA9373@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 12:33:03AM -0700, Greg KH wrote:
> Why not fix up the stuff that you know needs to be fixed?  It should
> not be merged until then at the least.

We'll keep plugging away; note that all this could take several months
(there are currently about 160 TODO items in the code base, plus
several more features to flesh out), and in the meantime, we would
like some general commentary from the community so we don't wind up
pouring time and effort in the wrong direction.

Thanks,
Mike
