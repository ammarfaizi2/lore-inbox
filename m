Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSETCj2>; Sun, 19 May 2002 22:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSETCj1>; Sun, 19 May 2002 22:39:27 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:57749 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S315717AbSETCj1>; Sun, 19 May 2002 22:39:27 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <14957.1021688031@ocs3.intra.ocs.com.au>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 20 May 2002 11:38:44 +0900
Message-ID: <buovg9j1r2j.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:
> Since release 2.0 [1], kbuild 2.5 has been faster as well as more
> accurate than the old build system.  A couple of people have complained
> that some restricted operations are slower in kbuild 2.5 [2] but
> overall it is faster

Yeah, but from your descriptions, it appears that the `restricted
operations' where KB 2.5 is slower are perhaps the _most common_ case
when debugging -- where you've change one or two source files and want
to rebuild the kernel to reflect that.

-Miles
-- 
"I distrust a research person who is always obviously busy on a task."
   --Robert Frosch, VP, GM Research
