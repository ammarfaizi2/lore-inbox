Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUGOMbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUGOMbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 08:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUGOMbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 08:31:33 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:39322 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266187AbUGOMbc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 08:31:32 -0400
Date: Thu, 15 Jul 2004 13:31:08 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Arjan van de Ven <arjanv@redhat.com>
cc: christophe.varoqui@free.fr, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: namespaces (was Re: [Q] don't allow tmpfs to page out)
In-Reply-To: <20040715080017.GB20889@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org>
References: <1089878317.40f6392d7e365@imp5-q.free.fr>
 <20040715080017.GB20889@devserv.devel.redhat.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004, Arjan van de Ven wrote:

> sure; namespaces can do a LOT

speaking of which, how does one use namespaces exactly? The kernel 
appears to maintain mount information per process, but how do you set 
this up?

neither 'man mount/namespace' nor 'appropos namespace' show up 
anything.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
 	warning: do not ever send email to spam@dishone.st
Fortune:
 	A man was reading The Canterbury Tales one Saturday morning, when his
wife asked "What have you got there?"  Replied he, "Just my cup and Chaucer."
