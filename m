Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUBRO13 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267426AbUBROZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:25:59 -0500
Received: from smtp0.libero.it ([193.70.192.33]:47801 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S267424AbUBROZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:25:51 -0500
Date: Wed, 18 Feb 2004 15:25:38 +0100
From: Domenico Andreoli <cavok@3.14freemail.it.minus.pi>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux 2.6.3 problem with e1000 nic
Message-ID: <20040218142538.GA3131@raptus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i just upgraded to kernel version 2.6.3 and my e1000 NIC cheesed to work.
in 2.6.2 it gave no problems.

e1000 support is compiled as module. i'm able to load module but as
soon as i do a "ifconfig eth0 10.0.0.1" system freezes and i have to
hit reset button.

let me know if i need to provide more information or test any patch.

cheers
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://filibusta.crema.unimi.it/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
