Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUJKHOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUJKHOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 03:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUJKHOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 03:14:47 -0400
Received: from colino.net ([213.41.131.56]:48636 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S268714AbUJKHOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 03:14:45 -0400
Date: Mon, 11 Oct 2004 09:14:11 +0200
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: Re: possible GPL violation by Free
Message-ID: <20041011091411.1335746c@pirandello>
X-Mailer: Sylpheed-Claws 0.9.12cvs122.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1097456379.27877.51.camel@frenchenigma>
In-Reply-To: <1097456379.27877.51.camel@frenchenigma>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Initiating SYN Stealth Scan against XX.XX.XX.254 [1660 ports] at 20:23
> PORT    STATE SERVICE
> 22/tcp  open  ssh
> 199/tcp open  smux
> MAC Address: 00:07:XX:XX:XX:XX (Freebox SA)
> Device type: general purpose
> Running: Linux 2.4.X|2.5.X
> OS details: Linux 2.4.0 - 2.5.20

I think you just scanned the router, or whatever network appliance it is,
behind the freebox :-)

The freebox is quite transparent when it's plugged to the network. Try to 
just plug in to your computer and assign it an IP using arp -s...

(not sure, however)
-- 
Colin
