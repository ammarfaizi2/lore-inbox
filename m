Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUHYXiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUHYXiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHYXiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:38:01 -0400
Received: from dp.samba.org ([66.70.73.150]:13753 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266281AbUHYXhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:37:46 -0400
Date: Wed, 25 Aug 2004 16:37:39 -0700
From: Jeremy Allison <jra@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825233739.GP10907@legion.cup.hp.com>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825163225.4441cfdd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 04:32:25PM -0700, Andrew Morton wrote:
> 
> We can add these new features tomorrow, as reiser4-only features, with a
> plan in hand to generalise them later.
> 
> -->>__if__<<-- we think these are features which Linux should offer.

Multiple-data-stream files are something we should offer, definately (IMHO).
I don't care how we do it, but I know it's something we need as application
developers.

Jeremy.
