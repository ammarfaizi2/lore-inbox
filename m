Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUGMOAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUGMOAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUGMOAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:00:36 -0400
Received: from [64.76.47.59] ([64.76.47.59]:63193 "HELO
	multivac.xnetcuyo.com.ar") by vger.kernel.org with SMTP
	id S264296AbUGMOAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:00:31 -0400
Date: Tue, 13 Jul 2004 10:00:27 -0400
From: Cristian Gimenez <cgimenez@xnetcuyo.com.ar>
To: linux-kernel@vger.kernel.org
Subject: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost
 synchronization
Message-Id: <20040713100027.3aab63bb.cgimenez@xnetcuyo.com.ar>
Organization: XNET Cuyo S.A.
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: 0%qTv?~llL?5e@Mf$9&g{+rnmciA-h~4WnaB&5Fezr5_3~RNiW8Z`j$.6W>{os0Rq?e]*t'
 /HHF}L82>=-rn<S,BN7Eg9[~HUs+ybDG.zYG>d1s)ZuMY!<_|gf_6~zwuARKQs6lOM#L`%]p-sTT"l
 VbO3fjwL>B0{Qph(>f"
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I have this message with a motherboard asus a7n8x-e deluxe with the
nforce2 ultra 400 chipset, tried a lot:

 with/without acpi
 with/without apic
 with psmouse.proto=bare in the kernel command line 
 with 2.6.7 and 2.6.8-rc1 

 my genius ps2/usb mouse works fine with my old abit kd7 motherboard with
 chipset via..

 any idea.. suggestion?


-- 

  Cristian Gimenez

