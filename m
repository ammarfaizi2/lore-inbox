Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTAJMow>; Fri, 10 Jan 2003 07:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbTAJMow>; Fri, 10 Jan 2003 07:44:52 -0500
Received: from fep20-0.kolumbus.fi ([193.229.0.47]:18527 "EHLO
	fep20-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S264956AbTAJMoK>; Fri, 10 Jan 2003 07:44:10 -0500
Subject: Suggestion
From: Harry Sileoni <stamina@kolumbus.fi>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Jan 2003 14:52:31 +0200
Message-Id: <1042203152.954.7.camel@vihta>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

While fighting for some time with my Dell Inspiron 8100 laptop and a new
kernel. No matter what I did in the APM-settings, the computer just
freezed after some minutes of uptime. Now I noticed a page witch
informed me that APIC support should not be used. I disabled APIC
support from the kernel config, and now it works perfect.

So, I suggest you add a line "This option might make your system hang
randomly" to the APIC support help page, so that other innocent people
with the same problem don't have to do hours of fighting with the APM,
which really wasn't the problem as I first though. :)

Thanks for a great kernel, and keep up the good work! :)


