Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSIESBI>; Thu, 5 Sep 2002 14:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSIESBI>; Thu, 5 Sep 2002 14:01:08 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:17576 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317978AbSIESBG>;
	Thu, 5 Sep 2002 14:01:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: [RFC] Alternative raceless page free, updated
Date: Thu, 5 Sep 2002 20:06:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Christian Ehrhardt <ulcae@in-ulm.de>
References: <3D644C70.6D100EA5@zip.com.au> <E17myRo-00068H-00@starship> <20020905160431.1671.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020905160431.1671.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17n11u-00069h-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated patch with improved/corrected page count handling
in shrink_cache along the lines we discussed:

   http://people.nl.linux.org/~phillips/patches/lru.race-2.4.19-3

-- 
Daniel

