Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSAFDnd>; Sat, 5 Jan 2002 22:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287682AbSAFDnO>; Sat, 5 Jan 2002 22:43:14 -0500
Received: from smtp1.Stanford.EDU ([171.64.14.23]:48038 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S287681AbSAFDnF>; Sat, 5 Jan 2002 22:43:05 -0500
Date: Sat, 5 Jan 2002 19:43:02 -0800
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [ingo scheduler patch] sorry --> 2.4.17-B4 works with no modules kernel....
Message-ID: <20020105194302.A293@av.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: vvikram@av.stanford.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi ingo,

my bad - sorry. it was some other stupid change of mine to the kernel [i.e 
not a fresh kernel] which caused the lockup. 

i am mailing this after booting from a _fresh_ kernel, no modules and 
your patch applied.

it works great:). hope this helps.

i can now start stress-testing it....

	Vikram

--
1) Linux av 2.4.17 #5 Sat Jan 5 19:11:24 PST 2002 i686 unknown
2) 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Duron(tm) Processor
stepping	: 0
cpu MHz		: 751.354
.
.
.

