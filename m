Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbTFQTvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTFQTve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:51:34 -0400
Received: from rth.ninka.net ([216.101.162.244]:8578 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264909AbTFQTvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:51:32 -0400
Subject: Re: BUG: Massive performance drop in conncetion time with 2.4.21
	(62KB)
From: "David S. Miller" <davem@redhat.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0306171518080.6807@filesrv1.baby-dragons.com>
References: <20030616141806.6a92f839.skraw@ithnet.com>
	 <Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>
	 <20030616145135.0ef5c436.skraw@ithnet.com>
	 <20030616151035.735fcaf2.martin.zwickel@technotrend.de>
	 <Pine.LNX.4.56.0306161413360.3114@filesrv1.baby-dragons.com>
	 <Pine.LNX.4.56.0306171518080.6807@filesrv1.baby-dragons.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055880260.19796.7.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jun 2003 13:04:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 12:33, Mr. James W. Laferriere wrote:
> 	Hello All ,  Here goes .  I made 'me too'ism in another thread
> 	that may be related to what I am presenting here .  After my .sig
> 	is what I hope to be enough pertitanent information to get the bug
> 	stomped on .  This is driving me crazy .  Also if someone would
> 	like to point me at a URL:/Method(s)/... to be able to acquire
> 	further information that would make the effort for those that
> 	really can code in the kernel jobs easier please do .
> 	The slow down mentioned below happens with any network based
> 	connection .  JimL

You can start by reporting the bug and all your debugging
informtion to the correct list.

Networking developers DO NOT sit on linux-kernel, it's too high
volume for them.  So use the correct list to report such
problems.

-- 
David S. Miller <davem@redhat.com>
