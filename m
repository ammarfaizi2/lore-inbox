Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267755AbTBUVja>; Fri, 21 Feb 2003 16:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267757AbTBUVja>; Fri, 21 Feb 2003 16:39:30 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:44439
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S267755AbTBUVj3>; Fri, 21 Feb 2003 16:39:29 -0500
Date: Fri, 21 Feb 2003 16:49:24 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: Mikael Pettersson <mikpe@user.it.uu.se>, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: UP local APIC is deadly on SMP Athlon
In-Reply-To: <200302212241.23251.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0302211645380.17290-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2003, Marc-Christian Petersen wrote:

> Don't do this. I am pretty sure it will break all Intels. I still cannot 
> understand why this fixes your AMD Athlon problem.

Oh, I don't doubt it -- it was just the result of my process of
elimination, trying to find the change that broke it in 2.4.10-pre12.

Somebody who understands the APIC stuff better than I do will have to draw 
some conclusions from this little experiment...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


