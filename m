Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136222AbRDVRIG>; Sun, 22 Apr 2001 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136223AbRDVRH4>; Sun, 22 Apr 2001 13:07:56 -0400
Received: from leng.mclure.org ([64.81.48.142]:54788 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136222AbRDVRHs>; Sun, 22 Apr 2001 13:07:48 -0400
Date: Sun, 22 Apr 2001 10:07:38 -0700
From: Manuel McLure <manuel@mclure.org>
To: John Cavan <johnc@damncats.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
Message-ID: <20010422100738.A7557@ulthar.internal.mclure.org>
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu> <3AE30609.21692820@damncats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AE30609.21692820@damncats.org>; from johnc@damncats.org on Sun, Apr 22, 2001 at 09:25:45 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.22 09:25 John Cavan wrote:
> Alan Cox wrote:
> > 2.4.3-ac12
> > o       Further semaphore fixes                         (David Howells)
> 
> Getting unresolved symbols in some modules (notably, for me, microcode.o
> and radeon.o)...
> 
> Using /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o
> /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
> symbol rwsem_up_write_wake
> /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
> symbol rwsem_down_write_failed

Same thing with tdfx.o...

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

