Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbRGOKDy>; Sun, 15 Jul 2001 06:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266013AbRGOKDn>; Sun, 15 Jul 2001 06:03:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5248 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266006AbRGOKD3>;
	Sun, 15 Jul 2001 06:03:29 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15185.27251.356109.500135@pizda.ninka.net>
Date: Sun, 15 Jul 2001 03:03:31 -0700 (PDT)
To: "George Bonser" <george@gator.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux default IP ttl
In-Reply-To: <CHEKKPICCNOGICGMDODJIEEIDKAA.george@gator.com>
In-Reply-To: <CHEKKPICCNOGICGMDODJIEEIDKAA.george@gator.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


George Bonser writes:
 > This has reduced considerably the number of ICMP messages where a packet has
 > expired
 > in transit from my server farms. Looks like there are a lot of clients out
 > there running
 > (apparently) modern Microsoft OS versions with networks having a lot of hops
 > (more than 64).

Why are there 64 friggin hops between machine in your server farm?
That is what I want to know.  It makes no sense, even over today's
internet, to have more than 64 hops between two sites.

Later,
David S. Miller
davem@redhat.com
