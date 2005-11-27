Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVK0W6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVK0W6e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 17:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVK0W6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 17:58:33 -0500
Received: from khc.piap.pl ([195.187.100.11]:38404 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751165AbVK0W6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 17:58:33 -0500
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Duncan Sands <duncan.sands@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: speedtch driver, 2.6.14.2
References: <200511232125.25254.s0348365@sms.ed.ac.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 27 Nov 2005 23:58:25 +0100
In-Reply-To: <200511232125.25254.s0348365@sms.ed.ac.uk> (Alistair John
 Strachan's message of "Wed, 23 Nov 2005 21:25:25 +0000")
Message-ID: <m3mzjp3dgu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

> However, on my rev 4.0 Speedtouch 330, I periodically get the message:
>
> ATM dev 0: error -110 fetching device status

Same here.

defiant:~$ dmesg | grep 'ATM dev 0: error -110 fetching device status' | wc -l
55
defiant:~$ uptime
 23:55:40 up 15 days, 23:34,  6 users,  load average: 0.05, 0.06, 0.06

It works fine, though.
-- 
Krzysztof Halasa
