Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTLKHS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTLKHS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:18:29 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:61659 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264400AbTLKHSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:18:25 -0500
Date: Wed, 10 Dec 2003 23:18:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <1293500000.1071127099@[10.10.2.4]>
In-Reply-To: <1071126929.5149.24.camel@idefix.homelinux.org>
References: <1071122742.5149.12.camel@idefix.homelinux.org><1288980000.1071126438@[10.10.2.4]> <1071126929.5149.24.camel@idefix.homelinux.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why would you want to *increase* HZ? I'd say 1000 is already too high
>> personally, but I'm curious what you'd want to do with it? Embedded
>> real-time stuff?
> 
> Actually, my reasons may sound a little strange, but basically I'd be
> fine with HZ=1000 if it wasn't for that annoying ~1 kHz sound when the
> CPU is idle (probably bad capacitors). By increasing HZ to 10 kHz, the
> sound is at a frequency where the ear is much less sensitive. Anyway, I
> thought some people might be interested in high HZ for other (more
> fundamental) reasons, so I posted the patch.

Ha! ;-) 
A hardware fix might be in order ;-)

M.

