Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbRFGSGQ>; Thu, 7 Jun 2001 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRFGSGG>; Thu, 7 Jun 2001 14:06:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262693AbRFGSF5>; Thu, 7 Jun 2001 14:05:57 -0400
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
To: yakker@aparity.com (Matt D. Robinson)
Date: Thu, 7 Jun 2001 19:03:13 +0100 (BST)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), davem@redhat.com (David S. Miller),
        yakker@aparity.com (Matt Robinson),
        piggy@em.cig.mot.com (La Monte H.P. Yarroll),
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
In-Reply-To: <Pine.LNX.4.30.0106062153540.3846-100000@nakedeye.aparity.com> from "Matt D. Robinson" at Jun 06, 2001 10:16:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15847l-0001gR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) Why would you limit people's ability to use solutions that are
>    not open source?  I mean, you don't do it in user space, so why
>    bother doing it in the kernel?  Doesn't the eventual goal of

It would be a nightmare to support or maintain and would be bad for the
Linux kernel. A random app is completely seperate so doesnt harm kernel
stability

> 2) Why won't Linux take FreeBSD OSL'd code into the kernel without
>    also requiring a dual license which also allows for the GNU GPL?

On legal advice. The BSD license has insufficient protection against
a variety of patent related problems. 

Alan

