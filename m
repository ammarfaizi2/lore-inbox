Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUFZCKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUFZCKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 22:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266923AbUFZCKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 22:10:22 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:29552 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266166AbUFZCKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 22:10:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: KBD failure in X?
Date: Fri, 25 Jun 2004 21:10:18 -0500
User-Agent: KMail/1.6.2
Cc: tom st denis <tomstdenis@yahoo.com>
References: <20040625225010.59377.qmail@web41108.mail.yahoo.com>
In-Reply-To: <20040625225010.59377.qmail@web41108.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406252110.18578.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 June 2004 05:50 pm, tom st denis wrote:
> Hi, I'm running Gentoo Linux on an x86 Laptop [Compaq Presario].  I've
> been running 2.4.26, 2.6.6-rc3 and 2.6.7 for a while [well 2.6.7 ever
> since it came out].
> 
> Now just recently I've been getting error [see attached dmesg log]. 
> XFree doesn't report any errors it just shuts down [yeah helpful!].
> 

If you referring to these messages:

atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.

they are usually harmless and pretty much everyone gets them. Why would
your X server shut down - I have no idea as it does not report any errors
(at least none in the log you provided).
 
-- 
Dmitry
