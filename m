Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUJaVNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUJaVNv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUJaVNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:13:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39397 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261659AbUJaVNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:13:34 -0500
Date: Sun, 31 Oct 2004 22:13:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Z Smith <plinius@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
In-Reply-To: <41855483.2090906@comcast.net>
Message-ID: <Pine.LNX.4.53.0410312213080.18107@yvahk01.tjqt.qr>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
 <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
 <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041030222720.GA22753@hockin.org> <Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr>
 <41855483.2090906@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> FBUI does not have 3d acceleration?
>
>The problem is 3d non-acceleration i.e. VESA and VGA
>would still have to be supported. I'm no 3d expert but
>I think there must be some software-based 3d function
>would require using floating point, which isn't allowed
>in the kernel.
>
>Also, might not software 3d open the kernel up to
>patent issues?

Whatever you do, 3D at the software level is slow, even with a fast comp.
See MESA.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
