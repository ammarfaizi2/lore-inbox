Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUD2BtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUD2BtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUD2BtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:49:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6532 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262605AbUD2BtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:49:00 -0400
Date: Wed, 28 Apr 2004 21:47:45 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, <brettspamacct@fastclick.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <20040428184008.226bd52d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0404282147000.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Andrew Morton wrote:

> OK, so it takes four seconds to swap mozilla back in, and you noticed it.
> 
> Did you notice that those three kernel builds you just did ran in twenty
> seconds less time because they had more cache available?  Nope.

That's exactly why desktops should be optimised to give
the best performance where the user notices it most...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

