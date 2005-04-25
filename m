Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVDYTSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVDYTSC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVDYTPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:15:50 -0400
Received: from mail.shareable.org ([81.29.64.88]:45224 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262747AbVDYTKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:10:50 -0400
Date: Mon, 25 Apr 2005 20:10:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: 7eggert@gmx.de, Jan Hudec <bulb@ucw.cz>,
       Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] private mounts
Message-ID: <20050425191015.GC28294@mail.shareable.org>
References: <3WWwR-3hT-35@gated-at.bofh.it> <3WWwU-3hT-49@gated-at.bofh.it> <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114445923.4480.94.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> I guess for this thread to make any progress, we need a set of coherent
> requirements from FUSE team.

Yes.  A list of use-cases from the FUSE team which would be nice 
to use would be a good start.  Then people who aren't so close to FUSE
can suggest alternative ways of doing those, until we whittle down to
the essential features that aren't already available in the kernel, if
any.

-- Jamie
