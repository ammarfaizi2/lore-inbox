Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282951AbRK0VEI>; Tue, 27 Nov 2001 16:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282955AbRK0VCK>; Tue, 27 Nov 2001 16:02:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47500 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282951AbRK0VB7>;
	Tue, 27 Nov 2001 16:01:59 -0500
Date: Tue, 27 Nov 2001 13:01:45 -0800 (PST)
Message-Id: <20011127.130145.35046186.davem@redhat.com>
To: andrew@pimlott.ne.mediaone.net
Cc: arjan@fenrus.demon.nl, heikki@indexdata.dk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: "Address family not supported" on RH IBM T23
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011127153119.A25554@pimlott.ne.mediaone.net>
In-Reply-To: <20011127200522.B27480@indexdata.dk>
	<m168nl3-000OVrC@amadeus.home.nl>
	<20011127153119.A25554@pimlott.ne.mediaone.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
   Date: Tue, 27 Nov 2001 15:31:19 -0500
   
   It would be even better to mention it in the kernel documentation,
   since iproute2 is fairly standard now.  I'm really not enough of a
   kernel hacker to change it, but the current Configure.help entry for
   CONFIG_NETLINK suggests that it is useful only for relatively
   obscure applications.

That is changing soon, the config options are in fact going away and
both will be on all the time if you have networking enabled at all.
