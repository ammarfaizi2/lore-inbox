Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131345AbRAABig>; Sun, 31 Dec 2000 20:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRAABi0>; Sun, 31 Dec 2000 20:38:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61199 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131345AbRAABiQ>; Sun, 31 Dec 2000 20:38:16 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Loopback device: limit?
Date: 31 Dec 2000 17:07:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <92ol8a$tbv$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't know who maintains the loopback device these days, but if
someone feels responsible, and would accept feature requests, I would
really like to see a "limit" option in addition to "offset".  This
would greatly simplify accessing partitioned disk images.

I could go ahead and try to do it, but if someone already knows the
code, I thought I'd throw it out there.

      -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
