Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312834AbSDEOiG>; Fri, 5 Apr 2002 09:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312839AbSDEOh4>; Fri, 5 Apr 2002 09:37:56 -0500
Received: from ns.suse.de ([213.95.15.193]:20499 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312834AbSDEOhm>;
	Fri, 5 Apr 2002 09:37:42 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
In-Reply-To: <p73k7rms6ba.fsf@oldwotan.suse.de.suse.lists.linux.kernel> <7853.1018011163@ocs3.intra.ocs.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Apr 2002 16:37:12 +0200
Message-ID: <p73u1qqus87.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> On a smaller config (full config takes too long when single threaded).
> 
> kbuild 2.4:
> 	make oldconfig dep bzImage modules	6:25
> 	make bzImage modules (no changes)	0:22
> 
> kbuild 2.5:
> 	make oldconfig installable		4:45
> 	make installable (no changes)		0:16

Hmm, can you explain the two minutes of difference ? Is the old build 
that inefficient? 

-Andi

