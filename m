Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUHBCNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUHBCNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 22:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUHBCNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 22:13:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50385 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266193AbUHBCNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 22:13:45 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <1091411152.973.1.camel@mindpipe>
References: <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu>  <20040801193043.GA20277@elte.hu>
	 <1091411152.973.1.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091412858.973.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 22:14:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 21:45, Lee Revell wrote:
> I will post numbers soon.

I will be out of town for a few days, so this is the last batch.  On my
hardware at least, all the latency problems have been resolved.

Delay   Count
-----   -----
6       2880
7       173347
8       311550
9       51870
10      16382
11      12687
12      11757
13      16355
14      14338
15      10980
16      8152
17      6837
18      5331
19      6593
20      5175
21      4181
22      2189
23      1280
24      622
25      461
26      327
27      230
28      195
29      183
30      277
31      271
32      263
33      224
34      143
35      78
36      62
37      78
38      66
39      60
40      55
41      39
42      25
43      14
44      7
45      6
46      5
47      4
48      1
49      5
50      6
51      3
52      1
54      1
55      2
56      2

Lee

