Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQLJHGa>; Sun, 10 Dec 2000 02:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQLJHGU>; Sun, 10 Dec 2000 02:06:20 -0500
Received: from durham-ar1-228-164.dsl.gte.net ([4.35.228.164]:20237 "EHLO
	smtp.gte.net") by vger.kernel.org with ESMTP id <S129572AbQLJHGH>;
	Sun, 10 Dec 2000 02:06:07 -0500
From: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14899.9262.948012.985914@critterling.garfield.home>
Date: Sun, 10 Dec 2000 01:35:26 -0500
To: Steven Walter <srwalter@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Freeze and reboot with 2.4.0-test12-pre5
In-Reply-To: <20001210000432.A7770@hapablap.dyn.dhs.org>
In-Reply-To: <20001210000432.A7770@hapablap.dyn.dhs.org>
X-Mailer: VM 6.87 under Emacs 20.7.1
Reply-To: v.j.orlikowski@gte.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

	One question:
	Do you have MTRR enabled?
	If so, a temporary workaround is to re-compile the kernel with
it disabled.

	This is getting to be something of an epidemic.
	As I said, AMD's docs state that the write-combining was
altered in the model and stepping stated. However, I would not
consider myself *nearly* experienced enough in x86 assembler to start
playing around with trying to work up a patch.

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
