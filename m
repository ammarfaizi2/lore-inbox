Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUBYDd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUBYDd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:33:28 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:14764 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262410AbUBYDd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:33:27 -0500
Date: Tue, 24 Feb 2004 22:32:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Woodruff, Robert J" <woody@co.intel.com>
cc: Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       <linux-kernel@vger.kernel.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       <marcelo.tosatti@cyclades.com>, <torvalds@osdl.org>,
       Troy Benjegerdes <hozer@hozed.org>, Greg KH <greg@kroah.com>
Subject: RE: PATCH - InfiniBand Access Layer (IBAL)
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C36CC@orsmsx410.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0402242232070.15091-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Woodruff, Robert J wrote:

> You may want to start talking more with some of your customers. I'm
> thinkin they might have a different opinion about wanting InfiniBand
> support in Linux.

What would customers do with an infiniband layer for
which no device drivers are available ?

Now if the device drivers were available, it would
make sense...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

