Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270496AbTGNC2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270498AbTGNC2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:28:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12173 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S270496AbTGNC2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:28:23 -0400
Message-Id: <200307140242.h6E2gokX004105@eeyore.valparaiso.cl>
To: Anthony Lichnewsky <lich@tuxfamily.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 doesn't boot at all on x86 
In-Reply-To: Message from Anthony Lichnewsky <lich@tuxfamily.org> 
   of "Sun, 13 Jul 2003 15:50:31 +0200." <3F1163A7.6010004@tuxfamily.org> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Sun, 13 Jul 2003 22:42:50 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Lichnewsky <lich@tuxfamily.org> said:
> After lilo, the kernel is uncompressed, then the screen goes black.
> the traditional init message is not even displayed
> ( INIT version 2.85 booting ).
> It accepts Ctrl+Alt+Suppr for reboot. but that's it.

Are you sure it isn't silently booting? My notebook does that with
2.5.7[45] (perhaps earlier) vga=0x317 (needed earlier to use the full
screen for VT; Toshiba 1800, Trident CyberBlade XPAi1 (rev 82) graphic
board stealing RAM for video)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
