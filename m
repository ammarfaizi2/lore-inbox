Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSJaDAu>; Wed, 30 Oct 2002 22:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265128AbSJaDAt>; Wed, 30 Oct 2002 22:00:49 -0500
Received: from 3-090.ctame701-1.telepar.net.br ([200.193.161.90]:59850 "EHLO
	3-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265126AbSJaDAr>; Wed, 30 Oct 2002 22:00:47 -0500
Date: Thu, 31 Oct 2002 01:06:54 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Linus Torvalds wrote:
> On Thu, 31 Oct 2002, Rusty Russell wrote:

> > ext2/ext3 ACLs and Extended Attributes
>
> I don't know why people still want ACL's. There were noises about them for
> samba, but I'v enot heard anything since. Are vendors using this?

Yes, people use it.  Not quite sure why though, I guess ACLs
buy some flexibility over the user/group/other model but if
the "unlimited groups" patch goes in (is in?) I'm happy ;)

Personally I do think either the unlimited groups patch or
ACLs are needed in order to sanely run a large anoncvs setup.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

