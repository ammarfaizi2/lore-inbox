Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281877AbRKSCM7>; Sun, 18 Nov 2001 21:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281884AbRKSCMv>; Sun, 18 Nov 2001 21:12:51 -0500
Received: from yuha.menta.net ([212.78.128.42]:12978 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S281877AbRKSCMj>;
	Sun, 18 Nov 2001 21:12:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: linux-kernel@vger.kernel.org
Subject: can max. cache size be selected?
Date: Mon, 19 Nov 2001 03:12:15 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0111190145510.766-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0111190145510.766-100000@mustard.heime.net>
MIME-Version: 1.0
Message-Id: <01111903121500.05756@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ask this because lowering the max. cache size could solve the problem that 
some people have with too much memory going to swap and, in consequence, 
making some apps unresponsive for a time

If max. cache size could be selected people who don't use much disk or just 
need to work with a lot of apps at the same time (desktop?) could reduce it 
to get better response when switching to inactive tasks who could have went 
to swap to grow the cache...

am i wrong with my logic?
is this possible?
  
