Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135575AbREEW6F>; Sat, 5 May 2001 18:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135580AbREEW5z>; Sat, 5 May 2001 18:57:55 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:29710 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S135575AbREEW5j>; Sat, 5 May 2001 18:57:39 -0400
Date: Sat, 5 May 2001 15:57:38 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David S. Miller" <davem@redhat.com>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <Pine.LNX.4.33.0105051550000.20277-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.33.0105051556280.20277-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also -- isn't it kind of wrong for arp to respond with addresses from
other interfaces?

what if ip_forward is 0?  or if there's some other sort of routing policy
in effect?

-dean

On Sat, 5 May 2001, dean gaudet wrote:

> i've got multiple ip networks on the same gigabit link...

p.s. that should have read "on the same gigabit switch".


