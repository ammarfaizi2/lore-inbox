Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbULPU7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbULPU7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbULPU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:59:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27878 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262014AbULPU6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:58:36 -0500
Subject: Re: 2.6 flavours
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041216203740.GA23365@middle.of.nowhere>
References: <003901c4e3ab$d86c8580$0e25fe0a@pysiak>
	 <20041216203740.GA23365@middle.of.nowhere>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103226893.21823.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 19:54:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 20:37, Jurriaan wrote:
> I've understood the 2.6.x-ac kernels started with some ide work, then
> included some serial fixes, and may or may not have other bug fixes.
> >From what I read, they are not as all-including as the 2.4.x-ac kernels
> were. Those I recognize most in the 2.6.x-mm kernels.

2.6.x-mm is more like some of the work the old 2.4-ac did in merging new
stuff (its also worth noting that 2.4-ac ended up more stable than 2.4
at times so -mm might be stable)

The -ac tree is trying to be fairly conservative. When I merge stuff
that is a little less conservative because it has to be done then I've
tried to put a note in the relnotes for that release warning people its
more testing grade.

> Whatever you think best, of course. That may be the release where Alan
> says 'Here's the new, experimental next-generation SATA code. It'll
> probably break every partition you have. Send me bug-reports' :-)

That would be Jeff 8)


