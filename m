Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271417AbTHFUKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271751AbTHFUKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:10:33 -0400
Received: from ns1.citynetwireless.net ([209.218.71.4]:27914 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S271417AbTHFUKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:10:32 -0400
Message-ID: <003701c35c56$4e4dcbd0$0500000a@bp>
From: "Ro0tSiEgE LKML" <lkml@ro0tsiege.org>
To: <linux-kernel@vger.kernel.org>
Subject: Soekris not exec'ing INIT
Date: Wed, 6 Aug 2003 15:07:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure that this is a specific kernel issue or not, but here goes...

I have a distro (hand compiled) running off of a CF card that's booting from
a Soekris (Elan SC520) net4501(and net4521) with the console kernel cmdline
set to ttyS0,19200n81, and the kernel messages show up fine and everything
over my serial terminal, but when the kernel goes to execute /sbin/init or
whatever I set init equal to (after the "Freeing unused kernel memory" bit),
nothing happens, init doesn't get executed (or I cannot see it). This same
CF card boots and runs fine from a normal PC, but from any Elan I have, init
never gets executed. What is wrong here?

Thanks...

--

