Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWESWVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWESWVU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWESWVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:21:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:11229 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751253AbWESWVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:21:19 -0400
Date: Sat, 20 May 2006 00:20:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: linux cbon <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
In-Reply-To: <446D8F36.3010201@aitel.hist.no>
Message-ID: <Pine.LNX.4.61.0605200018580.3250@yvahk01.tjqt.qr>
References: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com>
 <446D8F36.3010201@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The kernel already drives the files system, the
>> network, the cdrom, the cpu, etc. Why not the graphics
>> ?
>> 
> See above!  I also explained that in the previous email.
> But since you are slow at getting things,
> here it is again:
>
> Kernel graphichs are more dangerous than root graphichs, so
> you only make the security flaws worse by moving it into the kernel.

What about framebuffer, dri and agpgart? Does that belong to 
"graphics"? Because it's "in" the kernel... (or am I just missing 
something?)


Jan Engelhardt
-- 
