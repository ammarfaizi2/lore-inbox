Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291044AbSAaMgK>; Thu, 31 Jan 2002 07:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291045AbSAaMgC>; Thu, 31 Jan 2002 07:36:02 -0500
Received: from ns.ithnet.com ([217.64.64.10]:49163 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S291044AbSAaMfo>;
	Thu, 31 Jan 2002 07:35:44 -0500
Date: Thu, 31 Jan 2002 13:35:16 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Robbert Kouprie" <robbert@jvb.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
Message-Id: <20020131133516.68c78352.skraw@ithnet.com>
In-Reply-To: <002a01c1a9ee$1b6ddd20$020da8c0@nitemare>
In-Reply-To: <20020130220659.29bd66f5.skraw@ithnet.com>
	<002a01c1a9ee$1b6ddd20$020da8c0@nitemare>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 01:27:47 +0100
"Robbert Kouprie" <robbert@jvb.tudelft.nl> wrote:

> Thanks for your reaction Stephan, but I seriously doubt the change below
> would fix the problem... Also, as the problem appears randomly, and
> usually after some uptime, I obviously can not know about it being fixed
> if I constantly upgrade the kernel. I'd rather wait and see if it
> appears again in time after I did a kernel upgrade, and not trying every
> -pre while there's no mention on the mailing list of such bug being
> fixed.
> 
> Anyway, I just rebooted with 2.4.18-pre7-ac1, we'll see if it helps.

Hello Robert,

Well, I know the changes to the driver are rather ... small :-)
But on the other hand, I would not be all that sure that the bug is a
hundred percent related to the driver itself.
I run a working config with eepro100-driver, btw.

Regards,
Stephan


