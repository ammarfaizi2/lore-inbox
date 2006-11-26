Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935557AbWKZTV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935557AbWKZTV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 14:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935560AbWKZTV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 14:21:59 -0500
Received: from mx0.towertech.it ([213.215.222.73]:6873 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S935557AbWKZTV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 14:21:58 -0500
Date: Sun, 26 Nov 2006 20:21:48 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>, <akpm@osdl.org>,
       <linuxppc-dev@ozlabs.org>, <lethal@linux-sh.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <ralf@linux-mips.org>, "'Andi Kleen'" <ak@muc.de>, <paulus@samba.org>,
       <rmk@arm.linux.org.uk>, <davem@davemloft.net>, <kkojima@rr.iij4u.or.jp>
Subject: Re: NTP time sync
Message-ID: <20061126202148.190d5b4b@inspiron>
In-Reply-To: <009a01c7114a$b429f850$020120ac@Jocke>
References: <200611251522.19900.david-b@pacbell.net>
	<009a01c7114a$b429f850$020120ac@Jocke>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2006 12:04:54 +0100
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> Looking at rtc-dev.c I don't see a MARJOR number assigned to /dev/rtcN. Seems like
> it is dynamically allocated to whatever major number that is free.
> Is that the way it is supposed to be? How do I create a static /dev/rtcN in my /dev
> directory if the major number isn't fixed?
> Maybe I am just missing something, feel free to correct me :)

 udev ;)

 the concept of static numbers is quite old...

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

