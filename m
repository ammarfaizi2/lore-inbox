Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129933AbQKXI6U>; Fri, 24 Nov 2000 03:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129453AbQKXI6K>; Fri, 24 Nov 2000 03:58:10 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:34513 "EHLO
        fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
        id <S129933AbQKXI55>; Fri, 24 Nov 2000 03:57:57 -0500
From: kumon@flab.fujitsu.co.jp
Date: Fri, 24 Nov 2000 17:27:41 +0900
Message-Id: <200011240827.RAA13070@asami.proc.flab.fujitsu.co.jp>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95.2 is buggy
In-Reply-To: <20001124001051.D8881@wire.cadcamlab.org>
In-Reply-To: <UTC200011240157.CAA140709.aeb@aak.cwi.nl>
        <20001124171014.A26050@metastasis.f00f.org>
        <20001124001051.D8881@wire.cadcamlab.org>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson writes:
 > [Chris Wedgwood]
 > > taking away -O2 is a 'fix' for now... not a very good one though.
 > 
 > Not if you want function inlining to work.  The kernel *won't compile*
 > without optimization.

Using -O1 still works, at least for the demo program.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
