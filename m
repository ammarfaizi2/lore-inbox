Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277085AbRJKXzh>; Thu, 11 Oct 2001 19:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277089AbRJKXz1>; Thu, 11 Oct 2001 19:55:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22158 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277085AbRJKXzU>;
	Thu, 11 Oct 2001 19:55:20 -0400
Date: Thu, 11 Oct 2001 19:55:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Partitioning problems in 2.4.11
In-Reply-To: <20011012010846.A982@christian.chrullrich.de>
Message-ID: <Pine.GSO.4.21.0110111952010.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patches are on ftp.math.psu.edu/pub/viro - one against -ac is
A0-partition-AC10-12 and one against Linus' tree is A0-partition-S13-pre1.

If you've got missing partitions syndrome - check these.  If they don't
fix the problem - please, tell.

