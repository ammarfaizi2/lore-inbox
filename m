Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135761AbRA1AGt>; Sat, 27 Jan 2001 19:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135759AbRA1AGj>; Sat, 27 Jan 2001 19:06:39 -0500
Received: from [63.95.87.168] ([63.95.87.168]:55559 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S135758AbRA1AGb>;
	Sat, 27 Jan 2001 19:06:31 -0500
Date: Sat, 27 Jan 2001 19:06:29 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: David Schwartz <davids@webmaster.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127190629.A7467@xi.linuxpower.cx>
In-Reply-To: <20010127151428.H6821@xi.linuxpower.cx> <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com>; from davids@webmaster.com on Sat, Jan 27, 2001 at 02:18:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 02:18:31PM -0800, David Schwartz wrote:
> > Firewalling should be implemented on the hosts, perhaps with centralized
> > policy management. In such a situation, there would be no reason to filter
> > on funny IP options.
> 
> 	That's madness. If you have to implement your firewalling on every host,
> what do you do when someone wants to run a new OS? Forbid it?

No a standard management interface would be followed by every host. Not
unlike configuring your ipaddress with DHCP.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
