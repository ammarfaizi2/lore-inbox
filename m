Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTJJPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTJJPeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:34:16 -0400
Received: from gemini.smart.net ([205.197.48.109]:17927 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S262913AbTJJPeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:34:12 -0400
Message-ID: <3F86D179.2FD206B5@smart.net>
Date: Fri, 10 Oct 2003 11:34:17 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: hangs with IDE disks and SCSI CD-RW driver - 2.4.18 & 2.4.22; SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting complete system hangs apparently associated with
burning CDs on a SCSI CD-RW drive and using IDE disks on kernels
2.4.18 and 2.4.22 (with DMA disabled except for one disk on a 
Promise PDC20268-based controller) on a dual-Athlon MP system.
(And I do use a PS/2 mouse.)

At least with 2.4.18, I sometimes get temporary (5 to 10 seconds?)
hangs, seemingly when there's heavy disk activity.

Does this sound familiar to anyone?  Any suggestions (well, practical
ones, please)?



Daniel
-- 
Daniel Barclay
dsb@smart.net
