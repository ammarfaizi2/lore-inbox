Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJAB5e>; Sun, 30 Sep 2001 21:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274454AbRJAB5Y>; Sun, 30 Sep 2001 21:57:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3005 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274434AbRJAB5R>;
	Sun, 30 Sep 2001 21:57:17 -0400
Date: Sun, 30 Sep 2001 21:57:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
In-Reply-To: <Pine.GSO.4.21.0109301819220.12896-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109302152260.13829-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Update:  fixed a double-free bug in amiga_partition().  After that thing
seems to be working on Amiga disk sent by Jes (as in, "right amount
of partitions and reasonably looking boundaries").

Patch is on ftp.math.psu.edu/pub/viro/partition-b-S11-pre1.


