Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbULOWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbULOWyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbULOWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:54:19 -0500
Received: from lakermmtao11.cox.net ([68.230.240.28]:16795 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262525AbULOWyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:54:13 -0500
In-Reply-To: <BAY14-F1340F1BEA5470EBDE3DD2095AD0@phx.gbl>
References: <BAY14-F1340F1BEA5470EBDE3DD2095AD0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3CBFF1DE-4EEC-11D9-B94B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OS I/O operations concepts
Date: Wed, 15 Dec 2004 17:54:12 -0500
To: tony osborne <tonyosborne_a@hotmail.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 15, 2004, at 16:10, tony osborne wrote:

[snipped Java efficiency questions]

Overall, the Linux kernel is sufficiently fast and good at scheduling 
IO that
unless you're using well optimized C or assembly, you'll never be able 
to get
better IO results than by just letting the kernel manage it for you.  
Java has
sufficiently many extra layers of indirection that any slowdowns due to 
the
fact that Java is a heavily interpreted language are orders of magnitude
bigger  than any slowdowns from improper IO scheduling.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


