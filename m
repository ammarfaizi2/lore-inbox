Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUHDQLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUHDQLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267331AbUHDQLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:11:40 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:47827 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S267347AbUHDQKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:10:51 -0400
Date: Wed, 4 Aug 2004 12:10:46 -0400
To: James Morris <jmorris@redhat.com>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: Linux 2.6.8-rc3
Message-ID: <20040804161046.GD19282@fieldses.org>
References: <4110FB0E.230CE613@users.sourceforge.net> <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040722i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 12:00:26PM -0400, James Morris wrote:
> On Wed, 4 Aug 2004, Jari Ruusu wrote:
> 
> > Linus Torvalds wrote:
> > > Summary of changes from v2.6.8-rc2 to v2.6.8-rc3
> > [snip]
> > > James Morris:
> > >   o [CRYPTO]: Add i586 optimized AES
> > 
> > My work on aes-i586.S is only licensed under original three clause BSD
> > license. You do not have my permission to change the license.
> > 
> > Either use original license or drop this code.
> 
> Can you assert licensing restrictions which override the original author's
> (Brian Gladman)?  I don't know the answer, just asking.

Well, the license is an "or", so you're free to create derived works
under either or both licenses as you prefer.

But I don't even see why it's an issue; every source I've ever seen
seems to agree that the two are compatible, so you're always free to
relicense under 3-clause BSD under BSD or GPL anyway.  So, unless I'm
missing something, the "or GPL" probably doesn't do anything more than
make explicit something that was allowed already.

--Bruce Fields
