Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264006AbUDVMkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbUDVMkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 08:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbUDVMkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 08:40:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44966 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264006AbUDVMkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 08:40:24 -0400
Message-Id: <200404210224.i3L2OAHl020208@eeyore.valparaiso.cl>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [somewhat OT] binary modules agaaaain 
In-Reply-To: Message from Guennadi Liakhovetski <gl@dsa-ac.de> 
   of "Tue, 20 Apr 2004 17:08:45 +0200." <Pine.LNX.4.33.0404201705510.1869-100000@pcgl.dsa-ac.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 20 Apr 2004 22:24:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <gl@dsa-ac.de> said:
> On Tue, 20 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> > > A binary module is "considered good" if

> > This is a false assumption IMO no binary only modules can be "good".

> I agree! That was just an idea to make Linux life easier __if__ it
> __must__ live with binary modules.

Then call it "tolerable", not "good". ("Barely tolerable" comes to mind,
but might be a bit harsh...).

In any case, one of the biggest advantages of Linux is that in-kernel
interfaces aren't set in stone. They are extremely efficient because they
are expressed in terms of access to data structures and inline functions
and macros. The kernel is extremely flexible because it can be configured
in hundreds of different ways. All of this is lost through a fixed
binary-only interface to the binary blob inside the module.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
