Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRBDGCs>; Sun, 4 Feb 2001 01:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbRBDGCj>; Sun, 4 Feb 2001 01:02:39 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:17150 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S129169AbRBDGCa>;
	Sun, 4 Feb 2001 01:02:30 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Every Make option ends in error. 
In-Reply-To: Your message of "Sat, 03 Feb 2001 01:11:51 BST."
             <20010203011151.G3014@werewolf.able.es> 
Date: Sun, 04 Feb 2001 11:35:29 +1100
Message-Id: <E14PD9O-0001es-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010203011151.G3014@werewolf.able.es> you write:
> Or even better, if you are going to patch, do a 'cp -rl', and your new

ITYM cp -al, and the main benifit (for me) is that diff -urN takes ~10
seconds (cold cache), rather than minutes.

Rusty.
--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
