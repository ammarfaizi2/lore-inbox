Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRHaTls>; Fri, 31 Aug 2001 15:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHaTli>; Fri, 31 Aug 2001 15:41:38 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:47624 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S268922AbRHaTl3>;
	Fri, 31 Aug 2001 15:41:29 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Fri, 31 Aug 2001 20:37:07 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Why is tulip in its own directory (at least to 2.4.8) ?
Message-ID: <Pine.LNX.4.21.0108312031320.711-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just changed the NIC on my main box from a natsemi to a tulip. The
natsemi module was in /lib/modules/`uname -r`/kernel/drivers/net along
with the ppp modules, but the tulip module is in a tulip subdirectory.

Is there a good reason for this ?

Ken
-- 
   Never drink more than two pangalacticgargleblasters !
Home page : http://www.kenmoffat.uklinux.net


