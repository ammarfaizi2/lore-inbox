Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTIVQI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTIVQI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:08:57 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:39631 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261842AbTIVQIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:08:21 -0400
Date: Tue, 23 Sep 2003 02:07:01 +1000
From: CaT <cat@zip.com.au>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Kronos <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Athlon MCA
Message-ID: <20030922160701.GE514@zip.com.au>
References: <20030921143934.GA1867@dreamland.darkstar.lan> <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org> <20030921174731.GA891@redhat.com> <20030922142023.GC514@zip.com.au> <20030922144345.GC15344@redhat.com> <20030922150601.GD514@zip.com.au> <20030922160222.GF15344@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922160222.GF15344@redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 05:02:22PM +0100, Dave Jones wrote:
> On Tue, Sep 23, 2003 at 01:06:01AM +1000, CaT wrote:
>  > On Mon, Sep 22, 2003 at 03:43:45PM +0100, Dave Jones wrote:
>  > Status: (940040000000017a) Error IP valid
>  > Restart IP invalid.
>  > 
>  > What the snot does that mean? 8)
> 
> If this was from a kernel that didn't clear that bank on boot,
> it's bogus, and you can ignore it.

Ahhh. Phew. Thanks. I've been wondering. I take it this can show up on
a long-running system too? (hopefully someone will find this bit of
the thread useful because I saw 1 or 2 msgs in the past but I didn't
quite understand the answers)

-- 
	And so the stripper looks down and asks 'Can you breathe?'
		- from a friend's bucks night
