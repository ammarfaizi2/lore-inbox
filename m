Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUHYW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUHYW46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHYWxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:53:45 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:8075 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266245AbUHYWtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:49:12 -0400
Date: Thu, 26 Aug 2004 00:51:46 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <112698263.20040826005146@tnonline.net>
To: Andrew Morton <akpm@osdl.org>
CC: Hans Reiser <reiser@namesys.com>, hch@lst.de,
       linux-fsdevel@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <torvalds@osdl.org>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040825152805.45a1ce64.akpm@osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825152805.45a1ce64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And as I see it, there are two big issues:

> a) reiser4 extends the Linux API in ways which POSIX/Unix/etc do not
>    anticipate and 

> b) it does this within the context of just a single filesystem.

> I see three possible responses:

> a) accept the reiser4-only extensions as-is (possibly with post-review
>    modifications, of course) or

> b) accept the reiser4-only extensions with a view to turning them into
>    kernel-wide extensions at some time in the future, so all filesystems
>    will offer the extensions (as much as poss) or

> c) reject the extensions.


> My own order of preference is b) c) a).  The fact that one filesystem will
> offer features which other filesystems do not and cannot offer makes me
> queasy for some reason.

  This last sentence makes me wonder. Where is Linux heading? The idea
  that   a  FS  cannot  contain  features that no other FS has is very
  scary.

  I  am  all  for  uniformity, but not at the expense of shutting down
  advanced progress that Linux is so badly needing.

  This talk about old UNIX seems like people want to still live in the
  70'ies and not look forward. Please wake up!

  ~S


