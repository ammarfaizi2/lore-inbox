Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTDCSo4 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263417AbTDCSmA 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:42:00 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:59023 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id S263416AbTDCSkw 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:40:52 -0500
Date: Thu, 3 Apr 2003 20:52:18 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: ipv6 addr configuration question
Message-ID: <Pine.LNX.4.51.0304032048320.17115@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i am using radvd on my router to provide addresses for ipv6 enabled hosts.
The hosts on bootup 'ask' for an address and they receive a reply.

How do i force linux to 'ask' again?
Via sysctl? I have seen some knobs but nothing that i could use to
rediscover the address again.

(sorry, i do not remember if the correct name is neighbor discovery,
router solicitation, address autoconfiguration, or something else,
i am a ipv6 newbe)

Regards,
Maciej Soltysiak

