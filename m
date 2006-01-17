Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWAQN2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWAQN2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWAQN2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:28:25 -0500
Received: from AMarseille-252-1-93-6.w86-202.abo.wanadoo.fr ([86.202.148.6]:61595
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932456AbWAQN2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:28:25 -0500
To: mueller@teamix.net (Richard Mueller)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Problems with ARP and Linux
References: <43CCE123.1010608@teamix.net>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Organization: Uh?
Date: 17 Jan 2006 14:28:15 +0100
In-Reply-To: <43CCE123.1010608@teamix.net>
Message-ID: <m3slrn2dcg.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mueller@teamix.net (Richard Mueller) writes:
> Hy... (the same was posted to linux-net yesterday)
> [..]

It's the expected behavior. Look for arp_ignore and arp_announce under
linux/Documentation/networking/ip-sysctl.txt

-- 
Mathieu Chouquet-Stringer
    "Le disparu, si l'on vénère sa mémoire, est plus présent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exupéry, Citadelle --
