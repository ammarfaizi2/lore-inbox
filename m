Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284762AbRLRTfx>; Tue, 18 Dec 2001 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284696AbRLRTeJ>; Tue, 18 Dec 2001 14:34:09 -0500
Received: from air-1.osdl.org ([65.201.151.5]:33034 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S284843AbRLRTde>;
	Tue, 18 Dec 2001 14:33:34 -0500
Date: Tue, 18 Dec 2001 11:28:02 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andreas Bombe <bombe@informatik.tu-muenchen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1 API change summary
In-Reply-To: <20011218031427.GA5990@storm.local>
Message-ID: <Pine.LNX.4.33L2.0112181124460.20824-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Andreas Bombe wrote:

| One problem with following kernel development is that new APIs are
| nowhere really summarized outside of the list thread where they are
| developed (if there is a thread at all).  So maybe there's this great
| new function that simplifies something in your driver, but you don't
| know about it and only stumble across it much later (like 50 dev kernel
| revisions) and wish you'd known earlier.
|
| So someone should just collect the changes and post a summary to
| linux-kernel, now wouldn't that be useful ...
|
| [Silence, far away keyboards can be heard having "So I take it you
| volun..." typed on them.]
|
| ... and I will try to do that for the kernel 2.5 revisions.
|
| I have collected the API changes in 2.5.1 and summarized below.  I just
| read the patch for all the *.h files, so I may have confused something
| (like not realizing something just moved instead of being new).  I also
| don't know much about most of the areas I'm summarizing, any corrections
| are welcome.
|
| These summaries won't serve as documentation except when it's short and
| simple.  If there are big changes, I won't list every detail (I just
| remind you that there is something, you can read the source yourself).
| I will list changes which are global or at least apply to a whole
| subsystem.
|
| You'll also find stuff that's pretty much the talk of the week on
| linux-kernel and therefore well known, but these summaries should also
| serve as a overview ("when was what introduced") in combination with the
| kernel changelogs for those who get into 2.5 later (yes, I will archive
| these summaries on the web when I get a few together).
|
| So, here it goes:
|
| =======================================================================

[snip]

I guess you won't see summaries of proposals or actual changes
in IRC discussions (: , but linux-kernel (mailing list) does have
_some_ of them.  For links to the ones that I'm aware of (for
2.5.x), see

http://www.osdl.org/archive/rddunlap/linux-port-25x.html .

~Randy

