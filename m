Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUKCPab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUKCPab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUKCP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:27:33 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:36881 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261630AbUKCPZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:25:30 -0500
Date: Wed, 3 Nov 2004 16:19:39 +0100 (CET)
To: ak@suse.de
Subject: Re: dmi_scan on x86_64
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <wPc3Mf1E.1099495179.6511660.khali@gcu.info>
In-Reply-To: <20041103144006.GE24195@wotan.suse.de>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Any reason why dmi_scan is availble on the i386 arch and not on the
> > x86_64 arch? I would have a need for the latter (for run-time
> > identification purposes, not boot-time blacklisting).
>
> Here's a patch for testing.

Thanks Andi. Unfortunately, I don't own an x86_64 system myself, so I
won't be able to test your code. The system I have been working on had
been made temporarily remotely accessible to me by Tyan, but working on
kernel stuff remotely on a system you don't really control isn't
convenient, as you may easily imagine. I had them reboot it manually
several times (for some reason the box wouldn't reboot by itself when
asked to).

I think I need to get my hands on an x86_64 system I could really play at
will with, as more and more Linux individuals and companies are using
these. Any Linux-oriented company wanting to support the projects I am
working on (lm_sensors [1], dmidecode [2] and linux 2.6 itself) through
the donation of an x86_64 system?

Thanks,
Jean

[1] http://www.lm-sensors.nu/
[2] http://www.nongnu.org/dmidecode/
