Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbSLIVSC>; Mon, 9 Dec 2002 16:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbSLIVSC>; Mon, 9 Dec 2002 16:18:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:56500 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id <S266218AbSLIVSB>;
	Mon, 9 Dec 2002 16:18:01 -0500
Date: Mon, 9 Dec 2002 22:27:41 +0100
From: Kristof Sardemann <ksardem@linux01.gwdg.de>
X-Mailer: The Bat! (v1.60q) Personal
Reply-To: Kristof Sardemann <ksardem@linux01.gwdg.de>
Organization: KKI
X-Priority: 3 (Normal)
Message-ID: <523223727.20021209222741@linux01.gwdg.de>
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: bug in via-rhine network-driver (transmit timed out)
In-Reply-To: <20021209165847.GA17495@gtf.org>
References: <1653237694.20021209175407@linux01.gwdg.de>
 <20021209165847.GA17495@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> 
>> I successfully got the old transmit-out-error again ;-)
>> - and this time with "options via-rhine debug=3" in modules.conf.

JG> Does booting with "noapic" in lilo/grub fix this?
Yes, it did - as I mentioned in my previous postings ;)
..this was just a debug-report for source-bugfixing.

--
Bye.
Kristof <ksardem@linux01.gwdg.de>

