Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbRGUPyA>; Sat, 21 Jul 2001 11:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbRGUPxu>; Sat, 21 Jul 2001 11:53:50 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:1746 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267692AbRGUPxg>;
	Sat, 21 Jul 2001 11:53:36 -0400
Date: Sat, 21 Jul 2001 17:53:10 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: James Simmons <jsimmons@transvirtual.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.6] USB thinks I've got 2 keyboards
In-Reply-To: <Pine.LNX.4.10.10107210848220.29725-100000@transvirtual.com>
Message-ID: <Pine.LNX.4.33.0107211751480.28106-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> I have seen this. Look for a USB port on your keyboard. Some keyboards
> come with a port to plug a USB mouse into. The USB detects this other port
> and the HID layer reports it as a USB mouse. It is very normal.

The keyboard indeed does have 2 USB ports. The reported mouse is actually
there, and not connected to the keyboard.

	Igmar

-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

