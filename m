Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTLAVh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTLAVh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:37:57 -0500
Received: from lenin.net ([192.31.21.154]:49797 "HELO lenin.nu")
	by vger.kernel.org with SMTP id S264283AbTLAVgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:36:53 -0500
Date: Mon, 1 Dec 2003 13:36:51 -0800
From: "Peter C. Norton" <spacey-linux-kernel@lenin.nu>
To: Christoph Hellwig <hch@infradead.org>, Ian Kent <raven@themaw.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031201213651.GK18176@lenin.nu>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <Pine.LNX.4.44.0312012302310.9674-100000@raven.themaw.net> <20031201153316.B3879@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201153316.B3879@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 03:33:16PM +0000, Christoph Hellwig wrote:
> On Mon, Dec 01, 2003 at 11:04:21PM +0800, Ian Kent wrote:
> > Would you be willing to consider autofs4 patches that I would like 
> > included in 2.4?
> 
> What autofs4 patches?  bugfixes, features?  if they aren't in
> 2.6 yet I don't think it makes sense trying to get them into
> 2.4 anymore at all.

Ian has lots of bugfixes and and feature patches (like direct mounts)
going to the autofs mailing list.  Autofs4 has always had stability
issues in 2.4.x, and its been lacking in features.  This makes myself
and others run a bastard combination of amd, autofs and editing
/etc/fstab to get "automounter" features even close to the solaris
automounter.  If these can go into 2.4, which will be "stable" and in
use in lots of places for the next couple of years it could help by
encouraging the distros to get behind autofs4 (hint hint, redhat,
hint).

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.

