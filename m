Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQKVXl1>; Wed, 22 Nov 2000 18:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131939AbQKVXlR>; Wed, 22 Nov 2000 18:41:17 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:47631 "HELO ns1.suse.com")
        by vger.kernel.org with SMTP id <S129385AbQKVXlL>;
        Wed, 22 Nov 2000 18:41:11 -0500
Date: Wed, 22 Nov 2000 15:11:28 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: jani@virtualro.ic.ro
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] some cleanup in vgacon.c 
In-Reply-To: <Pine.LNX.4.10.10011212336210.11105-100000@virtualro.ic.ro>
Message-ID: <Pine.LNX.4.21.0011221456550.634-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	this is a newer cleaning patch for vgacon.c against test11.
> It includes the one I sent a couple of days ago.Could you check this too
> and if OK send it to Linus?Unless of course it violates the code-freeze
> policy :-)

The changes look fine except I have to question the *_scroll_enable
changes. Could someone with a ia64 box with SoftSDV  similator please test
this patch? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
