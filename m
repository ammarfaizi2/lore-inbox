Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264011AbRFEPUq>; Tue, 5 Jun 2001 11:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264012AbRFEPUg>; Tue, 5 Jun 2001 11:20:36 -0400
Received: from mx2out.umbc.edu ([130.85.253.52]:3512 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S264011AbRFEPU2>;
	Tue, 5 Jun 2001 11:20:28 -0400
Date: Tue, 5 Jun 2001 11:20:26 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
cc: <kdb@oss.sgi.com>
Subject: strange network hangs using kdb
Message-ID: <Pine.SGI.4.31L.02.0106051115190.11523908-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have two similar systems, using acenic gigabit cards, plugged into a
3com Superstack 3 10/100/1000 switch.

When we use kdb on one of the systems, the other system stops receiving
packets.

We've seen this from kernel 2.4.2 with the kdb patches from oss.sgi.com to
2.4.4 with the patches.

Are there any thoughts on this? Any other information that may prove to be
useful?

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.


