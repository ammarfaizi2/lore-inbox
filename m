Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUBSM5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 07:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267241AbUBSM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 07:57:11 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:40856 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267255AbUBSM5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 07:57:03 -0500
Date: Thu, 19 Feb 2004 12:54:41 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Hasso Tepper <hasso@estpak.ee>
cc: Jamie Lokier <jamie@shareable.org>, David Schwartz <davids@webmaster.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Quagga Dev <quagga-dev@lists.quagga.net>
Subject: Re: raw sockets and blocking
In-Reply-To: <200402191440.01035.hasso@estpak.ee>
Message-ID: <Pine.LNX.4.58.0402191252010.25392@fogarty.jakma.org>
References: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com>
 <20040219075343.GA4113@mail.shareable.org> <Pine.LNX.4.58.0402190831200.25392@fogarty.jakma.org>
 <200402191440.01035.hasso@estpak.ee>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Hasso Tepper wrote:

> And maybe it makes sense to mention that all packets ospf daemon
> sends to actually down ethernet interface are multicast packets.

nearly all. unicast packets are sent too.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Death is only a state of mind.

Only it doesn't leave you much time to think about anything else.
