Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRIBSBN>; Sun, 2 Sep 2001 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRIBSBE>; Sun, 2 Sep 2001 14:01:04 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1540 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268582AbRIBSAw>; Sun, 2 Sep 2001 14:00:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: __GFP_HIGH ignored?
Date: Sun, 2 Sep 2001 20:06:35 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902175947Z16091-32383+3016@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__GFP_HIGH is apparently ignored now.  Its intended function is performed 
instead by PF_MEMALLOC.  Should we take it out?

--
Daniel
