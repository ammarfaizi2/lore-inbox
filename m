Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbQKUXF4>; Tue, 21 Nov 2000 18:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbQKUXFg>; Tue, 21 Nov 2000 18:05:36 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:8709 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129708AbQKUXF1>;
	Tue, 21 Nov 2000 18:05:27 -0500
Date: Tue, 21 Nov 2000 23:34:45 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: dhinds@zen.stanford.edu, torvalds@transmeta.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Why not PCMCIA built-in and yenta/i82365 as modules
Message-ID: <Pine.LNX.4.21.0011212328570.30344-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The subject says it all. Is there any particular (technical) reason why I
must have both the generic pcmcia code and the controller support
built-in, or build all of them as modules?

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
