Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132592AbRDBBXd>; Sun, 1 Apr 2001 21:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132595AbRDBBXY>; Sun, 1 Apr 2001 21:23:24 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:63421 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S132592AbRDBBXL>;
	Sun, 1 Apr 2001 21:23:11 -0400
Organization: 
Date: Mon, 2 Apr 2001 04:19:40 +0300 (EET DST)
From: mythos <papadako@csd.uoc.gr>
To: <linux-kernel@vger.kernel.org>
Subject: MTRR
Message-ID: <Pine.GSO.4.33.0104020417530.21641-100000@iridanos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using Matrox G400 dualhead and a K7V I get the following message:

mtrr: base(0xe2000000) is not aligned on a size(0x1800000) boundary
mtrr: base(0xe2000000) is not aligned on a size(0x1800000) boundary
mtrr: no MTRR for e3800000,800000 found

Can anybody tell why is this happening?

	Mythos

