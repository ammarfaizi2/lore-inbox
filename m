Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVFBQdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVFBQdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFBQdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:33:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15003 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261182AbVFBQdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:33:22 -0400
Date: Thu, 2 Jun 2005 12:33:04 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Michael Halcrow <mhalcrow@us.ibm.com>
cc: Greg KH <greg@kroah.com>, Phillip Hellewell <phillip@hellewell.homeip.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] eCryptfs: eCryptfs kernel module
In-Reply-To: <20050602122807.GA8855@halcrow.us>
Message-ID: <Xine.LNX.4.44.0506021223320.5872-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Michael Halcrow wrote:

> On Thu, Jun 02, 2005 at 12:33:03AM -0700, Greg KH wrote:
> > Why not fix up the stuff that you know needs to be fixed?  It should
> > not be merged until then at the least.
> 
> We'll keep plugging away; note that all this could take several months
> (there are currently about 160 TODO items in the code base, plus
> several more features to flesh out), and in the meantime, we would
> like some general commentary from the community so we don't wind up
> pouring time and effort in the wrong direction.

Posting it here for comments should generate commentary, but it will also
help greatly if you format the patches properly, closely follow the kernel
coding style and include the patches in your emails.  The closer it looks
to be ready to apply to a real kernel tree, the more people will take
notice.

You can also ask for help with development, or if it's a really compelling
project, people may just dive in anyway.


- James
-- 
James Morris
<jmorris@redhat.com>



