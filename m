Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281738AbRKQWXU>; Sat, 17 Nov 2001 17:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRKQWXK>; Sat, 17 Nov 2001 17:23:10 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:28877 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S281738AbRKQWWy>;
	Sat, 17 Nov 2001 17:22:54 -0500
Date: Sat, 17 Nov 2001 17:22:53 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: SiS630 chipsets && linux 2.4.x kernel == snails pace?
Message-ID: <Pine.SGI.4.31L.02.0111171716420.12044432-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a few systems that use the SIS630 host bridge, the 5513 IDE bridge,
etc, etc, etc, and they are slooooooowwww under 2.4.x, whereas 2.2.19
performance seems to be fairly decent.

It does appear that support for the SiS5513 was added sometime recently,
or I've just gone blind ... But trying (2 hr make dep on 2.4.14) to get a
kernel with SiS5513 support started.

Anyway, various configs, system information, dmesg, and so forth can be
found at http://www.realityfailure.org/~jjasen/SiS630, as I'm gonna be
here for a while. :(

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

