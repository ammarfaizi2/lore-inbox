Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265522AbTF3I2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 04:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTF3I2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 04:28:38 -0400
Received: from tag.witbe.net ([81.88.96.48]:57864 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265303AbTF3I2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 04:28:36 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Russell King'" <rmk@arm.linux.org.uk>,
       "'David S. Miller'" <davem@redhat.com>
Cc: <cfriesen@nortelnetworks.com>, <paulus@samba.org>,
       <linux-kernel@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
       <linux-net@vger.kernel.org>
Subject: Re: [BUG]: problem when shutting down ppp connection since 2.5.70
Date: Mon, 30 Jun 2003 10:42:49 +0200
Message-ID: <008301c33ee3$968fca50$4100a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030630092337.B32593@flint.arm.linux.org.uk>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> The thread I replied to is about pppoe devices, so it isn't 
> limited to PCMCIA, although that seems to be the most popular 
> subset which causes the problem.
> 

I _do_ confirm this is definitely not related to a PCMCIA stuff
as far as I'm concerned. I'm using a desktop machine, no PCMCIA
stuff in the kernel I built, even as module.

Regards,
Paul

