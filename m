Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUFBTBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUFBTBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUFBTBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:01:32 -0400
Received: from vogsphere.datenknoten.de ([212.12.48.49]:34971 "EHLO
	vogsphere.datenknoten.de") by vger.kernel.org with ESMTP
	id S263818AbUFBTAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:00:31 -0400
Subject: Re: Strange DMA-errors and system hang with SMART (was: ...and
	system hang with Promise 20268)
From: Sebastian <sebastian@expires0604.datenknoten.de>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0405230737040.9783-100000@dirac.phys.uwm.edu>
References: <Pine.GSO.4.21.0405230737040.9783-100000@dirac.phys.uwm.edu>
Content-Type: text/plain
Message-Id: <1086202839.4439.11.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 21:00:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 23.05.2004 schrieb Bruce Allen um 14:46:
> Hi Sebastian,
> 
> Sorry it's taken me so long to reply.  My usual googling of smartmontools
> didn't turn this up because you changed the subject line and started a new
> thread.

Sorry for my late reply, too. I had been out of country and away from
Internet.

> I hadn't realized until now that the drive is an IBM GXP60.
> 
> smartctl is *supposed* to print a warning message for these drives, to
> tell users to look at http://www.geocities.com/dtla_update/index.html#rel
> for pointers to updated firmware for this drive!  What firmware version do
> you have?

Yes, the warning is there. However, there never had been a problem with
it for years until I upgraded the kernel. I probably should have paid
more attention to that warning... The problem is that most of the links
are broken on the page that you refer to.

I am pretty sure now that the DMA-error is related to smart as the
server run without problems for a couple of weeks until someone started
smartd again by mistake. Three days later the box froze again just after
1 am. 

> Meanwhile, what firmware version do you have?  I suggest you upgrade it --
> this may fix the problem.  The final firmware with the SMART fixes seems
> to be A46A.

ER4OA44A

Thanks for the infos,

Sebastian

