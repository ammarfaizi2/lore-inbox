Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTKESyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbTKESyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:54:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:41653 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263142AbTKESyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:54:04 -0500
Date: Wed, 5 Nov 2003 10:50:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: fastboot@lists.osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: kexec-260-test9-mm2.patch
Message-Id: <20031105105036.6e2563b2.rddunlap@osdl.org>
In-Reply-To: <20031105101024.22d95e89.rddunlap@osdl.org>
References: <Pine.NEB.4.58.0311020937100.3661@sdf.lonestar.org>
	<20031103162326.62a9de04.rddunlap@osdl.org>
	<Pine.NEB.4.58.0311041237210.13175@sdf.lonestar.org>
	<20031105101024.22d95e89.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| I've made all of these changes and posted the 2.6.0-test9-mm1 patch at
| 
| http://developer.osdl.org/rddunlap/kexec/2.6.0-test9/kexec-260-test9-mm1-cgm-ed.patch


The 2.6.0-test9-mm2 kexec patch only differs from test9-mm1 in the
top-level Makefile, but I made a separate patch file for it anyway.

It's here:
http://developer.osdl.org/rddunlap/kexec/2.6.0-test9/kexec-260-test9-mm2.patch

--
~Randy
