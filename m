Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271883AbTG2WXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTG2WXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:23:16 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:35558 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271883AbTG2WXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:23:15 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Tue, 29 Jul 2003 19:23:14 -0300 (E. South America Standard Time)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel-2.6.0-test2 speedy gonzalez mouse
Message-ID: <Pine.WNT.4.56.0307291914580.684@pervalidus>
X-X-Sender: fredlwm@fastmail.fm
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I only load mousedev it doesn't work. If I then load
> psmouse it goes insane with any of /dev/misc/psaux,
> /dev/input/mouse0, and /dev/input/mice.

The mouse works with ACPI, but then I lose sound and USB as in
2.4.21 with messages like 'ACPI: No IRQ known for interrupt
pin'. It also doesn't work with just IO-APIC, but even if it
did I lose network as in 2.4.21.
