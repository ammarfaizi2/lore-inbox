Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317846AbSGVWhC>; Mon, 22 Jul 2002 18:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSGVWhC>; Mon, 22 Jul 2002 18:37:02 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:46280 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317846AbSGVWhB>; Mon, 22 Jul 2002 18:37:01 -0400
Date: Mon, 22 Jul 2002 18:39:10 -0400
To: niv@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lmbench] tcp bandwidth on athlon
Message-ID: <20020722223910.GA1072@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi wrote:
> How did your Athlon perform in other tests relative
> to these other procs?

TCP bandwidth was the only strange really strange result.
Side by side lmbench for three processors is at:
http://home.earthlink.net/~rwhron/kernel/lmbench_comparison.html

> I only see the bitkeeper version thats almost a year old, online,
> where is the later version from?

The earlier version of bw_tcp is from lmbench-2.0-patch1.tgz
and the later version is from lmbench-2.0-patch2.tgz.

> Also, any chance you have network stats before/after?

I only ran oprofile on the athlon using "localhost".  
oprofile was to get an idea of the hot functions.
oprofile wasn't executing for the lmbench runs in the
link above.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

