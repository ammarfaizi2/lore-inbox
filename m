Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbUKAA4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUKAA4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUKAA4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 19:56:06 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:23427 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261709AbUKAAzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 19:55:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
Date: Sun, 31 Oct 2004 19:55:42 -0500
User-Agent: KMail/1.6.2
Cc: Alexander Gran <alex@zodiac.dnsalias.org>
References: <200410311903.06927@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200410311903.06927@zodiac.zodiac.dnsalias.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410311955.42507.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 01:03 pm, Alexander Gran wrote:
> Hi,
> 
> using 2.6.10-rc1-mm2 my keyboard and synaptics do not work. 2.6.9-rc4-mm1 is 
> fine. Both bootlogs are attached.

Do they work if you boot with i8042.noacpi boot option? If so please send me
your DSDT (cat /proc/acpi/dsdt > dsdt.hex).

Thanks!

-- 
Dmitry
