Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289174AbSAQPi7>; Thu, 17 Jan 2002 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289177AbSAQPik>; Thu, 17 Jan 2002 10:38:40 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:3996 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289174AbSAQPia>; Thu, 17 Jan 2002 10:38:30 -0500
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE][PATCH] accessfs v0.2
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 17 Jan 2002 16:38:10 +0100
Message-ID: <87d709rnrx.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I added some wishes/suggestions:

- ipv6 support (compiles ok, but not tested)
- keep capable() check, if configured
- configurable range of protected ports

The patch is available at:
<http://home.t-online.de/home/olaf.dietsche/linux/accessfs-2.4.14-0.2.patch.gz>

Regards, Olaf.
