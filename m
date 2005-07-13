Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVGMREA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVGMREA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVGMRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:03:46 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:38881 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261166AbVGMRCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:02:04 -0400
Date: Wed, 13 Jul 2005 19:00:00 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1665153860.20050713190000@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re: Open source firewalls
In-Reply-To: <014b01c587ca$83a77320$a20cc60a@amer.sykes.com>
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
 <014b01c587ca$83a77320$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Are there other open source firewall implementations
>> other than snort?
> I might be wrong and this might be a stupid answer but... How about
> iptables?
> iptables blocks everything incomind, allows, deny and forwards, so I think
> that is what you want?
Well iptables (which allows you to simply build firewall rulesets)
is the user-space part of the packet filter called netfilter in linux.
What it does (blocks or allows) is always up to the user, as with all firewalls,
except the majority of dummy windows firewalls and dummy linux scripts)

Others are of course in freebsd, netbsd, openbsd, opensolaris :-)

It really usually is a mixture of both kernel- and user-space code.

Regards,
Maciej


