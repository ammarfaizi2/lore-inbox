Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272012AbTG2Ts1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272037AbTG2Ts1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:48:27 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:57024 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S272012AbTG2Ts0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:48:26 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Tue, 29 Jul 2003 16:48:24 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.0-test2 speedy gonzalez mouse
Message-ID: <Pine.LNX.4.56.0307291643060.153@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I only load mousedev it doesn't work. If I then load
> psmouse it goes insane with any of /dev/misc/psaux,
> /dev/input/mouse0, and /dev/input/mice.

BTW, if I rmmod psmouse and startx the keyboard locks. It
doesn't if I don't load psmouse.
