Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbTABU3d>; Thu, 2 Jan 2003 15:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbTABU3d>; Thu, 2 Jan 2003 15:29:33 -0500
Received: from linux.kappa.ro ([194.102.255.131]:32157 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S266460AbTABU3c>;
	Thu, 2 Jan 2003 15:29:32 -0500
Date: Thu, 2 Jan 2003 22:37:49 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Samuel Flory <sflory@rackable.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
Message-ID: <20030102203749.GA30088@linux.kappa.ro>
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk> <20030102185921.GA28107@linux.kappa.ro> <3E14911C.7010009@rackable.com> <20030102192316.GA28781@linux.kappa.ro> <3E14976C.8090403@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E14976C.8090403@rackable.com>
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 11:47:56AM -0800, Samuel Flory wrote:
> 
>  Try setting the cd-rw as a slave, and the hard drive as a master.

My problem was that it was recognised as UDMA 133 on a 40 pin cable...
actually after those errors ( which repeats 4 times in the log ) the hard-drive
works fine.. I just thought of it as a bug.. I shall not use the hard-drive
in this configuration anyway...

> 
> -- 
> There is no such thing as obsolete hardware.
> Merely hardware that other people don't want.
> (The Second Rule of Hardware Acquisition)
> Sam Flory  <sflory@rackable.com>
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
      Teodor Iacob,
Network Administrator
Astral TELECOM Internet
