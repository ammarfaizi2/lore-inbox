Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUIHG3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUIHG3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIHG3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:29:22 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:57787 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S267466AbUIHG3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:29:20 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: george@mvista.com
Date: Wed, 08 Sep 2004 08:26:41 +0200
MIME-Version: 1.0
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
CC: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, paulus@samba.org,
       schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Message-ID: <413EC241.11051.265174@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <413DFCC2.7080405@mvista.com>
References: <Pine.LNX.4.58.0409070908290.8484@schroedinger.engr.sgi.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+93280@20040908.062108Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Sep 2004 at 11:24, George Anzinger wrote:

> Christoph Lameter wrote:
...
> > I thought the NTP daemon etc would even that out? ITC (TSC on IA64) is
> > used by default on IA64 for all time keeping purposes. The CPU has on chip
> > support for timer interrupt generation.
> 
> Yes, and it is designed (read the "rock" is carefully choosen) for time keeping. 

Believe me: NTP cannot repair a broken clock; it can only "tune" a clock that is 
systematically off.

...

Regards,
Ulrich


