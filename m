Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287317AbSACPRM>; Thu, 3 Jan 2002 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287322AbSACPRC>; Thu, 3 Jan 2002 10:17:02 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:64772 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287317AbSACPQz>;
	Thu, 3 Jan 2002 10:16:55 -0500
Date: Fri, 4 Jan 2002 02:15:09 +1100
From: Anton Blanchard <anton@samba.org>
To: Harald Holzer <harald.holzer@eunet.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020103151509.GC19873@krispykreme>
In-Reply-To: <1009649897.12942.2.camel@hh2.hhhome.at> <1009992652.1249.11.camel@wookie-laptop.pdx.osdl.net> <1009994687.12942.14.camel@hh2.hhhome.at> <1009995669.1253.17.camel@wookie-laptop.pdx.osdl.net> <1010015450.15492.19.camel@hh2.hhhome.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1010015450.15492.19.camel@hh2.hhhome.at>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Today i checked some memory configurations and noticed that the low
> memory decreases, when i add more memory to the system,
> and the size of reserved memory increases:
> 
> at 1GB ram, are 16,936kB low mem reserved.
> 4GB ram, 72,824kB reserved
> 8GB ram, 142,332kB reserved
> 16GB ram, 269,424kB reserved
> 32GB ram, 532,080kB reserved, usable low mem: 352 MB

> 64GB ram ?? 

If you need 64G of RAM and decent performance you dont want an x86.
Use a sparc64, alpha or ppc64 linux machine.

Anton
