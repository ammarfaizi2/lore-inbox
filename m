Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281372AbRKEWC5>; Mon, 5 Nov 2001 17:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281381AbRKEWCs>; Mon, 5 Nov 2001 17:02:48 -0500
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:20370 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S281372AbRKEWCp>; Mon, 5 Nov 2001 17:02:45 -0500
Date: Mon, 5 Nov 2001 13:34:29 -0800
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Subject: Re: APM/ACPI
Message-ID: <20011105133429.A5293@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1004726512.4921.41.camel@smiddle> <E15zjOs-0003FH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15zjOs-0003FH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 02, 2001 at 06:50:42PM +0000
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Nov 02, 2001 at 06:50:42PM +0000, Alan Cox wrote:
> If you compile in ACPI your box might work. You will need different 
> (development) tools and suspend wont work yet. ACPI is getting to the 
> useful point but not quite there - expect an adventure

Does poweroff work?  I cannot get it to work in 2.4.13...
Is this to be expected?  ACPI poweroff worked for me in
2.4.4 and 2.4.7, but alot of new options have been added
since then, maybe I just misconfigured it?

Oh and acpid does not work anymore in 2.4.13, should that
be upgraded too?

Thanks,
Mike
