Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbTGWO26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270345AbTGWO25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:28:57 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:15620 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S268160AbTGWO2z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:28:55 -0400
Message-ID: <200307231636280719.1CC18139@192.168.128.16>
In-Reply-To: <20030723070026.610ac63e.davem@redhat.com>
References: <200307182357260552.063FA10C@192.168.128.16>
 <200307231541180759.1C8EFFB1@192.168.128.16>
 <20030723070026.610ac63e.davem@redhat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Wed, 23 Jul 2003 16:36:28 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ARP with wrong ip?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2003 at 7:00 David S. Miller wrote:

>Maybe if you submitted the bug report and/or patch via
>to the "networking" mailing list, instead of linux-kernel
>and bugzilla where none of the "networking" developers
>pay attention, your report would be more likely to be looked
>at.

David,

I have sent the bug to linux-net:
http://marc.theaimsgroup.com/?l=linux-net&m=105862200011155&w=2

Where it has been ignored too.

Also, I have searched into ipv4/README:
Maintainers and developers for networking code sections

Code Section            Bug Report Contact
-------------------+-------------------------------------------
ipv4                    davem@caip.rutgers.edu,Eric.Schenk@dna.lth.se

where:

<Eric.Schenk@dna.lth.se>: host himmelsborg.cs.lth.se[130.235.16.11] said: 550
    5.1.1 <Eric.Schenk@dna.lth.se>... User unknown (in reply to RCPT TO
    command)


Also, I have searched into arp.c (the file patched) and seen:

* Fixes:
 *              Alan Cox        :       Removed the Ethernet assumptions in
 *                                      Florian's code

So, I also e-mailed Alan... without reply so far.


David, do you think I need to send the bug and patch to anyone else? Just tell me.

Regards,
Carlos Velasco


