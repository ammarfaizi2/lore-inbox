Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA3Ha0>; Tue, 30 Jan 2001 02:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRA3HaQ>; Tue, 30 Jan 2001 02:30:16 -0500
Received: from mail.inconnect.com ([209.140.64.7]:51360 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S129143AbRA3HaF>; Tue, 30 Jan 2001 02:30:05 -0500
Date: Tue, 30 Jan 2001 00:29:59 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: <linux-kernel@vger.kernel.org>
Subject: Multiplexing mouse input
In-Reply-To: <Pine.BSF.4.21.0101292238330.24261-100000@beppo.feral.com>
Message-ID: <Pine.SOL.4.30.0101300017310.12047-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My laptop has a touchpad builtin with two buttons, I also have an external
PS2 and/or USB mouse (3 buttons with scroll wheel).

I would like to be able to use the touchpad, and then plug in the mouse
(with either PS2 or USB connector) and use it without reconfiguring
anything.

In fact, it would be cool if I could use both at the same time.

Is this possible with the new "Input Drivers" in the 2.4 kernel?  Is it
possible with Linux at all?

As a comparison, at least two other OSes, Windows 2000 and NetBSD 1.5
multiplex mouse input and allow use of two (or more!) mice at the same
time.

Dax Kelson

NetBSD "wscons console driver" info:

http://www.netbsd.org/Documentation/wscons/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
