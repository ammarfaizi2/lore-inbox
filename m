Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUD0SDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUD0SDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUD0SDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:03:07 -0400
Received: from nysv.org ([194.29.194.54]:45725 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S264253AbUD0SAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:00:39 -0400
Date: Tue, 27 Apr 2004 21:00:35 +0300
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org
Subject: Re: I oppose Chris and Jeff's patch to add an unnecessary	additional namespace to ReiserFS
Message-ID: <20040427180035.GC29226@nysv.org>
References: <1082750045.12989.199.camel@watt.suse.com> <408D3FEE.1030603@namesys.com> <1083000711.30344.44.camel@watt.suse.com> <408D51C4.7010803@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408D51C4.7010803@namesys.com>
User-Agent: Mutt/1.5.4i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 11:15:32AM -0700, Hans Reiser wrote:

>The ReiserFS maintainer (me, in case you forgot;-) ) decided what 
>release acls would go into, and you disregarded it and wrote an 
>implementation that was inconsistent with the one planned.

Surely this can not be such a bad thing.

There's a lot of stuff flying around for the kernel that's not included
for one reason or another, probably because some maintainer doesn't like
it. What do people do? They patch it in by themselves.

If there's demand for something and someone provides it, what's the big
deal? It's still not supported by the maintainer, but it is maintained,
and it complies with standards.

Not that different from using some other scheduler or something than what's
provided in the mainline kernel. It can then be developed and possibly
make it into the mainline. Possibly. If the maintainer wants it.

Besides, Reiser4 was, and maybe is in the grand scheme of things, something
of the future and maybe interim solutions shouldn't be disregarded.

>ReiserFS portion.  ReiserFS did not go down the xattr path, and declared 
>that it would not do so long at the very beginning.  You are continuing 
>to try to force us down that path, and now you are claiming that because 

I hardly see this as forcing anyone to do anything.

No-one takes away anyone's freedom of choice, in fact, the very idea of
free software has been embodied here.

>V4 took longer than hacking V3 that means that xattrs are a pre-existing 
>api that we are heretically not conforming to.  Love it.

If xattrs were there first, why wouldn't they be pre-existing?-)

If Reiser4 attributes are better and stand a chance at becoming the new
standard, you should by Bog stand behind them and embrace this competition.

Let SuSE keep their customers happy and have people see that Reiser4
attributes are better.

>patches disregarded.  Stable branches do not get new semantics added to 
>them just before new major releases with preferred semantics come out.

This is of course only natural. But you allowed this to happen in your
choice of license and that's not a bad thing. Quite the contrary.

>Please consider contributing to enriching the collection of files that 
>act as attributes of other files in V4 instead of pulling your oars in 
>the other direction.  If you do, you will be (as usually) a valued 
>contributor.

Amen to that.

-- 
mjt

