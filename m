Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVLOHzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVLOHzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 02:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVLOHzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 02:55:38 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:26745 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965166AbVLOHzh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 02:55:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uWLdBUB4ZlDmGEMcZNJSmW5Z3lsBPVW+hp2s5pVKMeyoAZ7xNK6Fo1Rs89BZ5Ohr6QPHglXSGakjkpisHEdKZwre6V85s8+T+PWvLODPz2i7CLoeSCElo7jAulMmNN4cwTuz51anYfiqQA0dNt/aR1nMmDUv4alo91uQlgUYA14=
Message-ID: <21d7e9970512142355l782396f6s385df3c1b6b8b16f@mail.gmail.com>
Date: Thu, 15 Dec 2005 18:55:37 +1100
From: Dave Airlie <airlied@gmail.com>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [BUG] Xserver startup locks system... git bisect results
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051215043212.GA4479@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051215043212.GA4479@jupiter.solarsys.private>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     [drm] fix radeon aperture issue
>
> With this one applied, my machine locks up tight just after starting the
> Xserver.  Some info (dmesg, lspci, config) is here:

Can you give me an Xorg.0.log and /etc/X11/xorg.conf

I've got the same card here and it seems to work for me .. so maybe
its a configuration issue..

Dave.
