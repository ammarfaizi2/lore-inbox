Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSKEGMM>; Tue, 5 Nov 2002 01:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264786AbSKEGMM>; Tue, 5 Nov 2002 01:12:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27270 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262876AbSKEGML>;
	Tue, 5 Nov 2002 01:12:11 -0500
Date: Mon, 04 Nov 2002 23:11:25 -0800 (PST)
Message-Id: <20021104.231125.77059117.davem@redhat.com>
To: david@gibson.dropbear.id.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [TRIVIAL] Squash warning in net/ipv4/route.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021105061019.GK13707@zax.zax>
References: <20021105061019.GK13707@zax.zax>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Gibson <david@gibson.dropbear.id.au>
   Date: Tue, 5 Nov 2002 17:10:19 +1100

   This squashes an "implicit declaration of xfrm_init()" warning.
   
Yes, known and fixed in my tree.  I didn't push to Linus in time
for 2.5.46 because kernel.org was sick :-)
