Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293206AbSCJT6G>; Sun, 10 Mar 2002 14:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293207AbSCJT54>; Sun, 10 Mar 2002 14:57:56 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:23980 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S293206AbSCJT5q>; Sun, 10 Mar 2002 14:57:46 -0500
Date: Sun, 10 Mar 2002 11:58:25 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-ID: <220305212.1015761504@[10.10.2.3]>
In-Reply-To: <E16jVSZ-0008FH-00@the-village.bc.nu>
In-Reply-To: <E16jVSZ-0008FH-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So if anything its just not worth the effort of breaking the 
> 386 setup either 8). 386 SMP is a different issue but I don't 
> see any lunatics doing a 386 based sequent port thankfully.

Hey, don't count it out ... someone was emailing me a week or
two ago, asking what the internal structure of a Sequent Symmetry 
was, so that they could get Linux running on it. OK, so they gave 
up when I gave them an outline of what was in there, but ... ;-)

M.

PS. No I'm not suggesting we should support 386 SMP ;-)

