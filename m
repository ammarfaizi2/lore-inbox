Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbULRPHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbULRPHF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 10:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbULRPHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 10:07:05 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16018 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261174AbULRPHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 10:07:01 -0500
Date: Sat, 18 Dec 2004 16:06:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac16
In-Reply-To: <41C448BB.1020902@tmr.com>
Message-ID: <Pine.LNX.4.61.0412181606050.21338@yvahk01.tjqt.qr>
References: <41C2FF09.5020005@tebibyte.org><1103222616.21920.12.camel@localhost.localdomain>
 <1103349675.27708.39.camel@tglx.tec.linutronix.de> <41C448BB.1020902@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Andrea's fix and the selection changes should go into 2.6.10, but I
>> suspect that the VM gurus havent still reached a point, where they
>> agree. I also have the feeling that the problem is partially ignored.
>> Obviously has everybody plenty of memory in his boxes. </rant off>

Well you can always take out your VMware and cut it down to <few RAM> MB by 
hand, just to get an experience how "low-end" users feel.

> As someone who runs most new versions first on a 96MB (slow) machine, I would
> agree that this is a desirable change. I'm not sure yet if the selection is
> optimal, but it's better than the stock kernel, which seems to follow the "kill
> them all, let god sort it out" principle.



Jan Engelhardt
-- 
