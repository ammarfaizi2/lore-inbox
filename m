Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbRAEBdz>; Thu, 4 Jan 2001 20:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbRAEBdp>; Thu, 4 Jan 2001 20:33:45 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:36356 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S131629AbRAEBd3>; Thu, 4 Jan 2001 20:33:29 -0500
To: "J . A . Magallon" <jamagallon@able.es>
Cc: "Michael D . Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
In-Reply-To: <3A54DC87.5B861B7@goingware.com>
	<m37l4akdn5.fsf@austin.jhcloos.com>
	<20010105021623.C743@werewolf.able.es>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: "J . A . Magallon"'s message of "Fri, 5 Jan 2001 02:16:23 +0100"
Date: 04 Jan 2001 19:33:28 -0600
Message-ID: <m31yuikck7.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JA" == J A Magallon <jamagallon@able.es> writes:

JA> How is each of your setups, ie, what is compiled in kernel and
JA> what is a module ? 

Good point.  I never tried w/ APM in kernel and ACPI as module.  Just
both in and ACPI in / APM module.  (And that last was only due to
operator error when configing the kernel.)

Kernel version may also be a factor when both are in.

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
