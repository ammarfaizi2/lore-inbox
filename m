Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTDXFFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTDXFEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:04:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14600 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264415AbTDXFE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:04:28 -0400
Date: Wed, 23 Apr 2003 22:16:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <Pine.LNX.4.10.10304232112401.2033-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0304232204480.19326-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Apr 2003, Andre Hedrick wrote:
> 
> Now the digital signing issue as a means to protect possible embedded or
> distribution environments is needed.  DRM cuts two ways and do not forget
> it!

This is _the_ most important part to remember.

Security is a two-edged sword. It can be used _for_ you, and it can be
used _against_ you. A fence keeps the bad guys out, but by implication the
bad guys can use it to keep _you_ out, too.

The technology itself is pretty neutral, and I'm personally pretty
optimistic that _especially_ in an open-source environment we will find
that most of the actual effort is going to be going into making security
be a _pro_consumer_ thing. Security for the user, not to screw the user.

Put another way: I'd rather embrace it for the positive things it can do
for us, than have _others_ embrace it for the things it can do for them.

> For those not aware, each and every kernel you download from K.O is DRM
> signed as a means to authenticate purity.

Yup. And pretty much every official .rpm or .deb package (source and
binary) is already signed by the company that made that package, for
_your_ protection. This is already "accepted practice", so allowing 
signing is not something new per se, including on a binary level.

So what I hope this discussion brings as news is to make people aware of
it. And that very much includes making people aware of the fact that there
are some scary sides to signing stuff - and that they're par for the
course, and part of the package. I know for a fact that a number of 
people were hoping for the upsides without any of the downsides. That's 
not how it works.

			Linus

