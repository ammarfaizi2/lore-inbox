Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312488AbSDEMBs>; Fri, 5 Apr 2002 07:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312484AbSDEMBj>; Fri, 5 Apr 2002 07:01:39 -0500
Received: from ns.suse.de ([213.95.15.193]:30482 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312488AbSDEMB2>;
	Fri, 5 Apr 2002 07:01:28 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
In-Reply-To: <7022.1018005968@ocs3.intra.ocs.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Apr 2002 14:01:13 +0200
Message-ID: <p73k7rms6ba.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> 
> More accurate kernel build, easier to write and understand Makefiles,
> 30% faster than kbuild 2.4.  Now the nay-sayers will have to find
> something else to complain about!

I assume with kbuild 2.4 you mean the current makefiles. How does it
compare at a single threaded build without -j ? 

You seem to have written an awful lot of code just to build something.
Perhaps it would have been easier to just replace make completely with a 
custom builder @)

-Andi
