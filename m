Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUIOOLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUIOOLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUIOOIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:08:48 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:57472 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266216AbUIONfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:35:08 -0400
Date: Wed, 15 Sep 2004 15:34:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-ID: <20040915133408.GB6158@wohnheim.fh-wedel.de>
References: <413AA7B2.4000907@yahoo.com.au> <20040904230210.03fe3c11.davem@davemloft.net> <413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au> <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org> <1094405830.2809.8.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409051051120.2331@ppc970.osdl.org> <20040915132712.GA6158@wohnheim.fh-wedel.de> <20040915132904.GA30530@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040915132904.GA30530@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 September 2004 15:29:04 +0200, Arjan van de Ven wrote:
> 
> if you haven't pinned those pages then you have lost already.

Bug reports say otherwise.  Could you explain "pinning" to a newbie
like me?

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
