Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132984AbQLKB3r>; Sun, 10 Dec 2000 20:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132680AbQLKB32>; Sun, 10 Dec 2000 20:29:28 -0500
Received: from durham-ar1-228-164.dsl.gte.net ([4.35.228.164]:3332 "EHLO
	smtp.gte.net") by vger.kernel.org with ESMTP id <S131822AbQLKB3V>;
	Sun, 10 Dec 2000 20:29:21 -0500
From: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14900.9881.51332.993356@critterling.garfield.home>
Date: Sun, 10 Dec 2000 19:58:01 -0500
To: Julian Anastasov <ja@ssi.bg>
CC: srwalter@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
In-Reply-To: <Pine.LNX.4.21.0012102150490.2089-100000@u>
In-Reply-To: <14898.50377.593756.7641@critterling.garfield.home>
	<Pine.LNX.4.21.0012102150490.2089-100000@u>
X-Mailer: VM 6.87 under Emacs 20.7.1
Reply-To: v.j.orlikowski@gte.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You appear to be right, sir.
The SVGA xserver was what I was using. Changing over to use the S3
server, and then adding back in MTRRs, seems to have solved the
trouble. I'll let you know if it returns, but for now, all appears
well.

Victor
-- 
Victor J. Orlikowski
======================
v.j.orlikowski@gte.net
vjo@raleigh.ibm.com
vjo@us.ibm.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
