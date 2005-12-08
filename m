Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVLHUp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVLHUp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVLHUp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:45:59 -0500
Received: from quelen.inf.utfsm.cl ([200.1.19.194]:15752 "EHLO
	quelen.inf.utfsm.cl") by vger.kernel.org with ESMTP id S932360AbVLHUp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:45:58 -0500
Message-Id: <200512082028.jB8KSsgp020672@pincoya.inf.utfsm.cl>
To: Diego Calleja <diegocg@gmail.com>
cc: dirk@steuwer.de, rdunlap@xenotime.net, wli@holomorphy.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: Linux in a binary world... a doomsday scenario 
In-Reply-To: Message from Diego Calleja <diegocg@gmail.com> 
   of "Thu, 08 Dec 2005 17:14:44 BST." <20051208171444.511b2567.diegocg@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Thu, 08 Dec 2005 17:28:54 -0300
From: Horst von Brand <vonbrand@pincoya.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja <diegocg@gmail.com> wrote:

[...]

> I think that the infrastructure for building such database automatically
> is already there: In the same way MODULE_DEVICE_TABLE is used by hotplug
> & friends to load the right module you can use MODULE_DEVICE_TABLE to
> build a database of the devices supported by a kernel compiled with
> "make allmodconfig", parse it and put it in a web page.

What use is it to me when I'm going to buy ShinyCard-9900, and the database
tells me that RandomChip 2530a is supported? The packages rarely tell you
what chips are in the cards, moreover there have been cases of /very
similar/ card versions (i.e., SomeThing-990 and SomeThing-990+, or
Card-897a and Card-897b) being /totally/ different inside). The only
reliable way to find out if it works is a test drive. Distributions like
Ubuntu are invaluable here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

