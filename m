Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbSKLJo3>; Tue, 12 Nov 2002 04:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266444AbSKLJo3>; Tue, 12 Nov 2002 04:44:29 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:60434 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S266443AbSKLJo1>; Tue, 12 Nov 2002 04:44:27 -0500
Date: Tue, 12 Nov 2002 20:49:49 +1100
From: john slee <indigoid@higherplane.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs
Message-ID: <20021112094949.GE17478@higherplane.net>
References: <20021112093259.3d770f6e.spyro@f2s.com> <1037094221.16831.21.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037094221.16831.21.camel@bip>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 10:43:41AM +0100, Xavier Bestel wrote:
> I'm wondering if a totally userspace solution could replace devs ?
> Something using hotplug + sysfs and creating directories/nodes as they
> appear on the system. This way, the policy (how do I name what) could be
> moved out of the kernel.

curious!  you mean similar to (and a logical extension of) the 'disks'
command in solaris?  at least i think thats what its called...

j.

-- 
toyota power: http://indigoid.net/
