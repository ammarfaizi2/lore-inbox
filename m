Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbSKLJ7E>; Tue, 12 Nov 2002 04:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSKLJ7E>; Tue, 12 Nov 2002 04:59:04 -0500
Received: from AGrenoble-101-1-1-247.abo.wanadoo.fr ([193.251.23.247]:16365
	"EHLO awak") by vger.kernel.org with ESMTP id <S266438AbSKLJ7D> convert rfc822-to-8bit;
	Tue, 12 Nov 2002 04:59:03 -0500
Subject: Re: devfs
From: Xavier Bestel <xavier.bestel@free.fr>
To: john slee <indigoid@higherplane.net>
Cc: Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112094949.GE17478@higherplane.net>
References: <20021112093259.3d770f6e.spyro@f2s.com>
	<1037094221.16831.21.camel@bip>  <20021112094949.GE17478@higherplane.net>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Nov 2002 11:05:36 +0100
Message-Id: <1037095536.16831.27.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 12/11/2002 à 10:49, john slee a écrit :
> On Tue, Nov 12, 2002 at 10:43:41AM +0100, Xavier Bestel wrote:
> > I'm wondering if a totally userspace solution could replace devs ?
> > Something using hotplug + sysfs and creating directories/nodes as they
> > appear on the system. This way, the policy (how do I name what) could be
> > moved out of the kernel.
> 
> curious!  you mean similar to (and a logical extension of) the 'disks'
> command in solaris?  at least i think thats what its called...

I don't know solaris (from an admin POV), but I meant something like,
well, devfs. On top of which we could add feature like device naming
stability across system upgrades (I know solaris does that).

Xav

