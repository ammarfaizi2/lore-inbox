Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTKOXCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 18:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTKOXB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 18:01:59 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:44422 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262076AbTKOXB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 18:01:59 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 15 Nov 2003 15:01:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Dan Creswell <dan@dcrdev.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hard lock on 2.6-test9
In-Reply-To: <3FB5F79F.703@dcrdev.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0311151501000.1997-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003, Dan Creswell wrote:

> Chipset is E7505 with dual Xeons.
> 
> Under X, I can provoke a lock just by waggling the mouse.  I've had the 
> machine connected up to a serial console with nmi_watchdog=1 and, when 
> the machine dies, nothing is printed on the console (I guess that makes 
> it *very* bad :( ).

Is NMI really enabled?

$ cat /proc/interrupts



- Davide


