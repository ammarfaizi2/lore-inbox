Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbRGXBLA>; Mon, 23 Jul 2001 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266490AbRGXBKu>; Mon, 23 Jul 2001 21:10:50 -0400
Received: from hibernia.clubi.ie ([212.17.32.129]:37786 "HELO
	fogarty.jakma.org") by vger.kernel.org with SMTP id <S266417AbRGXBKm>;
	Mon, 23 Jul 2001 21:10:42 -0400
Date: Tue, 24 Jul 2001 02:10:33 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, <sourav@csa.iisc.ernet.in>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Arp problem
In-Reply-To: <3B5CC947.2E027588@candelatech.com>
Message-ID: <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
X-Dumb-Filters: aryan marijuiana cocaine heroin hardcore cum pussy porn teen tit sex lesbian group
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Ben Greear wrote:

> The arp-filter patch is in the kernel since about 2.4.4, so you just need
> to turn it on...

on a related note:

if i have 2 logical subnets on the wire, linux listening on both, is
there any way to get linux to fully route packets between the 2
subnets?

at the moment it just issues a icmp_redirect, which isn't good enough
for certain hosts (eg win9x at least).

> Ben

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
How come everyone's going so slow if it's called rush hour?

