Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265052AbUFANq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbUFANq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUFANqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:46:55 -0400
Received: from pD952C7EB.dip.t-dialin.net ([217.82.199.235]:61133 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S265052AbUFANqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:46:48 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Enable suspend/resuming of e1000
Date: Tue, 1 Jun 2004 15:41:26 +0200
User-Agent: KMail/1.6.2
References: <200405281404.10538@zodiac.zodiac.dnsalias.org> <200406011504.40549@zodiac.zodiac.dnsalias.org> <20040601132429.GA5926@elf.ucw.cz>
In-Reply-To: <20040601132429.GA5926@elf.ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011541.26425@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 1. Juni 2004 15:24 schrieben Sie:
> Problem with interrupts? Look if /proc/interrupts increase when you
> ping it. You may want to try "noapic".
> 									Pavel

it doesn't, apic is disabled, as my thinkpad does (did, have to recheck that 
with a more recent kernel, though) not work with apic enabled.

Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
