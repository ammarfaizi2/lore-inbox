Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318591AbSHADcw>; Wed, 31 Jul 2002 23:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318599AbSHADcw>; Wed, 31 Jul 2002 23:32:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25485 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318591AbSHADcv>; Wed, 31 Jul 2002 23:32:51 -0400
Date: Wed, 31 Jul 2002 20:34:22 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Lincoln Dale <ltd@cisco.com>
cc: David Luyer <david_luyer@pacific.net.au>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Message-ID: <771740373.1028147661@[10.10.2.3]>
In-Reply-To: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
References: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No shit. Now, how do you create a ps executable that handles
> a 2.4.xx kernel with a modified HZ value? People did this all
> the time. I got many bug reports from these people, so don't
> go saying they don't exist. Remember: one executable, running
> on both of the these:
>
> <rant deleted>

Is it somehow impossible to just export HZ in /proc, and read it?
Doesn't seem too hard to me.

M.

