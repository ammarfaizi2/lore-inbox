Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131420AbRCKOWX>; Sun, 11 Mar 2001 09:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRCKOWN>; Sun, 11 Mar 2001 09:22:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14092 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131420AbRCKOWA>; Sun, 11 Mar 2001 09:22:00 -0500
Subject: Re: PROBLEM: RTL8029 stops working after being flood pinged
To: tange@tange.dk (Ole Tange)
Date: Sun, 11 Mar 2001 14:24:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103110236010.973-100000@tigger.tange.dk> from "Ole Tange" at Mar 11, 2001 03:42:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14c6ly-00005s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1.] One line summary of the problem:
>      RTL8029 based card stops receiving data after being flood pinged

This is probably the apparent hardware problem in the Intel APIC. There is
a workaround for it in 2.4.2-ac

