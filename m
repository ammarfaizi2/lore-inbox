Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131384AbQKVL6X>; Wed, 22 Nov 2000 06:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbQKVL6F>; Wed, 22 Nov 2000 06:58:05 -0500
Received: from nas1-13.kmp.club-internet.fr ([213.44.17.13]:58620 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S131384AbQKVL5w>;
	Wed, 22 Nov 2000 06:57:52 -0500
Message-Id: <200011221123.MAA18669@microsoft.com>
Subject: Re: BUG: 2.2.17 and APM
From: Xavier Bestel <xavier.bestel@free.fr>
To: Val Henson <vhenson@esscom.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001121121626.A727@esscom.com>
In-Reply-To: <200011210849.JAA08318@microsoft.com>  <20001121121626.A727@esscom.com>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 22 Nov 2000 10:23:29 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When you say "halt", do you mean "shutdown -h now" or do you mean that
> the computer just powers off?
> 
> I have a VAIO and suspend works fine (hibernate isn't supported).  I'd
> be interested in seeing your /etc/sysconfig/apm*.

Just "off", i.e. as soon as it should start entering standby or hibernation,
it powers off directly, leaving the system in a bad, bad state :o(

I stress that it (seemed it) worked fine with 2.2.16, and that I didn't
change my config scripts (/etc/sysconfig/apm*) until then. But with
2.2.17, I have random power-off instead of clean standby/hibernate.

Xav
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
