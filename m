Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRA0Bqm>; Fri, 26 Jan 2001 20:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130765AbRA0Bqd>; Fri, 26 Jan 2001 20:46:33 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:51976 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S129867AbRA0BqT>; Fri, 26 Jan 2001 20:46:19 -0500
Date: Fri, 26 Jan 2001 17:46:12 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac12
In-Reply-To: <E14MIgn-0003G5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31ksi3.0101261742080.598-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Alan Cox wrote:

[skipped]

Modules still don't load:

=== Cut ===
ide-mod.o: Can't handle sections of type 32131
ide-probe-mod.o: Can't handle sections of type 256950710
ide-disk.o: Can't handle sections of type 688840897
ext2.o: Can't handle sections of type 69429248
=== Cut ===

Section types are exactly the same in ac9,10,11,12.

Is it supposed to be this way? Does anybody care? Or may be I'm the only one
who uses modules?

Any ideas? Can I help to debug it? Please let me know if I can be of any
help...

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8890
Henderson, NV, 89014

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
