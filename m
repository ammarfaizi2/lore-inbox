Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUH0T1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUH0T1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUH0T1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:27:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65193 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267385AbUH0TSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:18:50 -0400
Date: Fri, 27 Aug 2004 15:13:47 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, <jamie@shareable.org>,
       <christophe@saout.de>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <christer@weinigel.se>, <spam@tnonline.net>, <akpm@osdl.org>,
       <wichert@wiggy.net>, <jra@samba.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <412F7D22.5050101@namesys.com>
Message-ID: <Pine.LNX.4.44.0408271456210.10272-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Hans Reiser wrote:

> It is the tail that should not wag the dog.

That's no reason for dismissing technical questions with
vigorous handwaving.

> New semantics are going to break backups other than dd.  We need a LOT
> of new semantics if we don't want to be inferior to Apple and MS.

Technical objections need to be addressed, otherwise Linux
will end up inferior to Apple and MS.  Whatever choice we
end up making, it should be something that's both workable
and elegant.

It would be really nice if all the technical issues were
worked out on linux-kernel before the files-as-directories
stuff gets merged.  There are quite a few technical questions
in the thread that haven't been answered yet...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

