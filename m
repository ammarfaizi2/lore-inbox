Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTLBISC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 03:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTLBISC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 03:18:02 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:43275 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261522AbTLBISA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 03:18:00 -0500
Date: Tue, 2 Dec 2003 08:17:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Peter C. Norton" <spacey-linux-kernel@lenin.nu>
Cc: Ian Kent <raven@themaw.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202081754.A19277@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Peter C. Norton" <spacey-linux-kernel@lenin.nu>,
	Ian Kent <raven@themaw.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <Pine.LNX.4.44.0312012302310.9674-100000@raven.themaw.net> <20031201153316.B3879@infradead.org> <20031201213651.GK18176@lenin.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031201213651.GK18176@lenin.nu>; from spacey-linux-kernel@lenin.nu on Mon, Dec 01, 2003 at 01:36:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 01:36:51PM -0800, Peter C. Norton wrote:
> Ian has lots of bugfixes and and feature patches (like direct mounts)
> going to the autofs mailing list.  Autofs4 has always had stability
> issues in 2.4.x, and its been lacking in features.  This makes myself
> and others run a bastard combination of amd, autofs and editing
> /etc/fstab to get "automounter" features even close to the solaris
> automounter.  If these can go into 2.4, which will be "stable" and in
> use in lots of places for the next couple of years it could help by
> encouraging the distros to get behind autofs4 (hint hint, redhat,
> hint).

Well, it looks like you're a bit later for 2.4 with that.  Get them
into 2.6 and if they prove good we can backport the bugfix portions.
As for Red Hat:  I'll bet the next Red Hat product will be based on
a 2.6 kernel, as is fedora as their public beta testing community
whizbang version.

