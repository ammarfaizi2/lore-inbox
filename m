Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTJIAbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTJIAbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:31:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:41165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261844AbTJIAbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:31:22 -0400
Date: Wed, 8 Oct 2003 17:22:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fastboot@osdl.org
Subject: kexec update (2.6.0-test7)
Message-Id: <20031008172235.70d6b794.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've updated the kexec patch for 2.6.0-test7.
It can be found at
  http://developer.osdl.org/rddunlap/kexec/2.6.0-test7/kexec-260t7.patch

A slightly different version of it can also be found in the
-osdl patchset at
  http://developer.osdl.org/shemminger/patches/2.6/2.6.0-test7/

The userspace tools are at
  http://www.xmission.com/~ebiederm/files/kexec/
You'll need to update the kexec-syscall.c file for the correct
kexec syscall number (274).
I intend to try to automate this (somehow).

Feedback/patches welcome.

--
~Randy
