Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRBMG7v>; Tue, 13 Feb 2001 01:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbRBMG7l>; Tue, 13 Feb 2001 01:59:41 -0500
Received: from sense-gold-134.oz.net ([216.39.162.134]:3076 "EHLO
	sense-gold-134.oz.net") by vger.kernel.org with ESMTP
	id <S130521AbRBMG7e>; Tue, 13 Feb 2001 01:59:34 -0500
Date: Mon, 12 Feb 2001 22:59:50 -0800 (PST)
From: al goldstein <gold@sense-gold-134.oz.net>
To: kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.1 swaps hardware addresses for ethernet cards
Message-ID: <Pine.LNX.4.21.0102122250180.848-100000@sense-gold-134.oz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2 ether cards 59x (eth0) and 509 (eth1). I have been adding 509
at boot in lilo.conf. Using this same config in 2.4.1 results in 
the hardware addresses for the cards to be swapped. If I remove 509 from 
Lilo I get the same result. Suggestions would be appreciated  

