Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbRFNPQE>; Thu, 14 Jun 2001 11:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263049AbRFNPPx>; Thu, 14 Jun 2001 11:15:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46256 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263043AbRFNPPl>;
	Thu, 14 Jun 2001 11:15:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15144.54553.798998.159393@pizda.ninka.net>
Date: Thu, 14 Jun 2001 08:15:37 -0700 (PDT)
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <p05100306b74e83f6860f@[207.213.214.37]>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
	<3B28C6C1.3477493F@mandrakesoft.com>
	<p05100306b74e83f6860f@[207.213.214.37]>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Lundell writes:
 > That's right, of course. A small problem is that dev->slot_name 
 > becomes ambiguous, since it doesn't have any hose identification. Nor 
 > does it have any room for the hose id; it's fixed at 8 chars, and 
 > fully used (bb:dd.f\0).

Sure, Jeff and I already said that slot name strings need to change.

Later,
David S. Miller
davem@redhat.com

