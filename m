Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbTLIJA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266162AbTLIJA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:00:57 -0500
Received: from AGrenoble-101-1-3-30.w193-253.abo.wanadoo.fr ([193.253.251.30]:65508
	"EHLO awak") by vger.kernel.org with ESMTP id S266161AbTLIJAz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:00:55 -0500
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Greg KH <greg@kroah.com>
Cc: Witukind <witukind@nsbm.kicks-ass.org>, recbo@nishanet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031209075619.GA1698@kroah.com>
References: <200312081536.26022.andrew@walrond.org>
	 <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com>
	 <20031208233755.GC31370@kroah.com>
	 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	 <20031209075619.GA1698@kroah.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070960433.869.77.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 10:00:34 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 09/12/2003 à 08:56, Greg KH a écrit :
>   A:  That is correct.  If you really require this functionality, then
>       use devfs.  There is no way that udev can support this, and it
>       never will.

That's something I don't understand: I thought that with a well
configured hotplug+udev system, you'll never have to worry about loading
drivers on device-node open() because all drivers should be auto-loaded
and all device-nodes should be auto-created.

Am I wrong ?

	Xav

