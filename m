Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132920AbQLRBah>; Sun, 17 Dec 2000 20:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132910AbQLRBa2>; Sun, 17 Dec 2000 20:30:28 -0500
Received: from mdj.nada.kth.se ([130.237.224.206]:57864 "EHLO mdj.nada.kth.se")
	by vger.kernel.org with ESMTP id <S132920AbQLRBaM>;
	Sun, 17 Dec 2000 20:30:12 -0500
From: Mikael Djurfeldt <mdj@mdj.nada.kth.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test13-pre3: Makefile problem in drivers/video
Reply-to: Mikael Djurfeldt <djurfeldt@nada.kth.se>
Message-Id: <E147oeY-0006H7-00@mdj.nada.kth.se>
Date: Mon, 18 Dec 2000 01:59:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to build video.o as a module, video.o doesn't get copied
to /lib/modules/* during installation.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
