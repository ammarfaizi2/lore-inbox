Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSJaDNO>; Wed, 30 Oct 2002 22:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265144AbSJaDNN>; Wed, 30 Oct 2002 22:13:13 -0500
Received: from relay.snowman.net ([63.80.4.38]:53522 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S265143AbSJaDNN> convert rfc822-to-8bit;
	Wed, 30 Oct 2002 22:13:13 -0500
Date: Wed, 30 Oct 2002 22:19:32 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031031932.GQ15886@ns>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 22:16:56 up 88 days,  5:52, 11 users,  load average: 0.05, 0.12, 0.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@conectiva.com.br) wrote:
> On Wed, 30 Oct 2002, Linus Torvalds wrote:
> > On Thu, 31 Oct 2002, Rusty Russell wrote:
> 
> > > ext2/ext3 ACLs and Extended Attributes
> >
> > I don't know why people still want ACL's. There were noises about them for
> > samba, but I'v enot heard anything since. Are vendors using this?
> 
> Yes, people use it.  Not quite sure why though, I guess ACLs
> buy some flexibility over the user/group/other model but if
> the "unlimited groups" patch goes in (is in?) I'm happy ;)
> 
> Personally I do think either the unlimited groups patch or
> ACLs are needed in order to sanely run a large anoncvs setup.

The feeling I got on this was the ability to let users define their own
groups.  Perhaps I'm not following it closely enough but that was the
impression I got in terms of "what this does for us"; I'm probably
missing other things.  Just that ability would be nice in my view
though.  Isn't it something that's been in AFS for a long time too?
I've got a few friends who've played with AFS before (at CMU and the
like) and really enjoyed the ACLs there.

	Just my thoughts,

		Stephen
