Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVC0RJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVC0RJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVC0RJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:09:57 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13576 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261482AbVC0RJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:09:56 -0500
Date: Sun, 27 Mar 2005 19:09:36 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Aaron Gyes <floam@sh.nu>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327170936.GQ30052@alpha.home.local>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <Pine.LNX.4.61.0503271052130.22393@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503271052130.22393@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 10:57:13AM +0200, Jan Engelhardt wrote:
> > BTW, to all you "But my drivers must be proprietary!" nerds out there,
> > take a look at 3ware, Adaptec, etc.  They have _great_ hardware and yet
> > they release all of their drivers under the GPL.  They get free updates
> > to new kernel APIs too!
> 
> Well, it boils down to the full sourcecode. NVidia does only half.
> Other good examples besides 3ware are: VMware kernel modules and
> SUNWut/SRSS3 Linux Kernel modules.
> 
> Looks like there's only the GPU industry left that thinks somebody could 
> "mis"use the kmod to make them (:one company) inferior on the market.

Probably because it's true. What if everyone could notice that they are
cheating such as rendering one inferior frame every other frame or things
like this to increase performance ? Afterall, opensource also prevents you
from cheating, or at least lets others fix your "bugs".

Willy

