Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131119AbQLUVMf>; Thu, 21 Dec 2000 16:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbQLUVMZ>; Thu, 21 Dec 2000 16:12:25 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:22532 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S131228AbQLUVMN>;
	Thu, 21 Dec 2000 16:12:13 -0500
Date: Fri, 22 Dec 2000 01:16:59 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: Wiring down Pages
Message-ID: <Pine.SOL.3.96.1001222011552.20552A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I am a novice in this exciting kernel world, so
my questions may be a bit naive, please bear with me.(I am student at
IISc, Bangalore).

	Suppose I want to wire-down( as they call in BSD ) a page in
memory, how I go about doing that? (I guess by setting the PG_locked bit
of the flags field in the struct page, I can do it, am I right?)

sourav
--------------------------------------------------------------------------------
SOURAV SEN    MSc(Engg.) CSA IISc BANGALORE URL : www2.csa.iisc.ernet.in/~sourav 
ROOM NO : N-78      TEL :(080)309-2454(HOSTEL)          (080)309-2906 (COMP LAB) 
--------------------------------------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
