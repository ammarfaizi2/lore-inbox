Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267917AbRGRTCp>; Wed, 18 Jul 2001 15:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbRGRTCf>; Wed, 18 Jul 2001 15:02:35 -0400
Received: from zero.tech9.net ([209.61.188.187]:30219 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S267918AbRGRTCT>;
	Wed, 18 Jul 2001 15:02:19 -0400
Subject: Re: [PATCH] ACP Modem (Mwave)
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3B55C5C2.47A5AA5B@yahoo.co.uk>
In-Reply-To: <OF67CA15A0.AE538F3E-ON85256A8D.00580180@raleigh.ibm.com>
	<Pine.LNX.4.33.0107181129430.18913-100000@screwy.haywired.net> 
	<3B55C5C2.47A5AA5B@yahoo.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 18 Jul 2001 15:02:24 -0400
Message-Id: <995482947.6721.29.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I would add
one more datapoint ...
kernel 2.4.6-ac5 +
mwave-patch-20010718 on
IBM ThinkPad 600 41U:
works fine thus far.

The userspace tools,
init script, etc also
work flawless on the
current RedHat Rawhide
(beta for 7.2).

[12:16:52]rml@icbm:~#
cat /proc/version 
Linux version 2.4.6-ac5
(rml@icbm) (gcc version
2.96 20000731 (Red Hat
Linux 7.1 2.96-94)) #1
Tue Jul 17 16:16:14 EDT
2001

I don't use modules (I
enabled them
specifically for this),
so I would like to see
this able to compile
into the kernel.  To
that effect, I think
this should be submitted
for inclusion into the
kernel proper.  It is
GPL now, and it is
apparently stable.
Perhaps Alan can pick it
up for the -ac tree?

Once its in the kernel
RedHat and others need
to be encouraged to
include packages in
their distribution :) --
i see SuSE does already.

Good job IBM.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

