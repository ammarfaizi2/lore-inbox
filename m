Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRA0V7K>; Sat, 27 Jan 2001 16:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbRA0V7A>; Sat, 27 Jan 2001 16:59:00 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:53896 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S129604AbRA0V6u>; Sat, 27 Jan 2001 16:58:50 -0500
Date: Sat, 27 Jan 2001 22:02:03 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: <patrick.mourlhon@wanadoo.fr>
cc: Paul Jakma <paulj@itg.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: routing between different subnets on same if.
In-Reply-To: <20010127194659.A1326@MourOnLine.dnsalias.org>
Message-ID: <Pine.LNX.4.31.0101272200410.2119-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001 patrick.mourlhon@wanadoo.fr wrote:

> did you install routed on the linux machine ?

no i have my routes statically set, but that wouldn't make a
difference. Routed just adds/deletes entries from the kernel table as
neccessary and lets the kernel do the forwarding as neccessary. so
it'd make no difference.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
The greatest productive force is human selfishness.
		-- Robert Heinlein

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
