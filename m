Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271863AbRHUVsI>; Tue, 21 Aug 2001 17:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271868AbRHUVr6>; Tue, 21 Aug 2001 17:47:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:30354 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271863AbRHUVrv>;
	Tue, 21 Aug 2001 17:47:51 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 21 Aug 2001 21:48:06 GMT
Message-Id: <200108212148.VAA192742@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [semi-OT] alignment of partitions at a cylinder boundary
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I had some discussions with people about the need
to align partitions at a cylinder boundary.
Since the details are not documented anywhere that I know of,
I added what I think I know at
  http://www.win.tue.nl/~aeb/linux/Large-Disk-6.html#ss6.2
Additions and corrections are welcome.

Andries
