Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSHRWqy>; Sun, 18 Aug 2002 18:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHRWqy>; Sun, 18 Aug 2002 18:46:54 -0400
Received: from h-64-105-136-5.SNVACAID.covad.net ([64.105.136.5]:16102 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316532AbSHRWqx>; Sun, 18 Aug 2002 18:46:53 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 18 Aug 2002 15:49:20 -0700
Message-Id: <200208182249.PAA01041@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: IDE?
Cc: linux-kernel@vger.kernel.org, stp@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-08-17, Alan Cox wrote:
>Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
>controllers would also be much appreciated. That way we can get good
>coverage tests and catch badness immediately

	From visiting the osdl.org booth a LinuxWorld, I understand
that they have a farm of 150 deliberately differently configured
computers on which you are supposed to be able to run your own
kernel tests on your own kernels.

	They have a procedure for adding new tests described at
http://www.osdl.org/stp/HOWTO.Port_Tests.html.

	I think it would be informative to run 2.4 ported code and
Martin's stack against IDE tests on this system.  With this, you could
not only spot problems, but see problems happening in a certain pattern
which could sometimes simplify finding a bug.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
