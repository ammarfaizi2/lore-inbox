Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135583AbRD1SRC>; Sat, 28 Apr 2001 14:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135587AbRD1SQx>; Sat, 28 Apr 2001 14:16:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33969 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135583AbRD1SQj>;
	Sat, 28 Apr 2001 14:16:39 -0400
Date: Sat, 28 Apr 2001 14:16:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <Pine.GSO.4.21.0104231814030.4968-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0104281414490.23302-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch rediffed to 2.4.4, otherwise - no changes (2.4.4 has a
fix for ext2 race, but it's unrelated to the thing).

  	Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4.gz
Please, help with testing.
								Al

