Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270336AbTGSRBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270395AbTGSRBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:01:00 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:60879 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S270336AbTGSRA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:00:59 -0400
Date: Sat, 19 Jul 2003 18:15:56 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG REPORT 2.6.0-test1] PPP breakage.
Message-Id: <20030719181556.2ec33b38.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Im having some problems that appear ppp related.

Im using synce to connect to my WinCE handheld. with 2.5.70 this works great using the ipaq driver (modified to recognise the toshiba e750 USB id).

the ipaq driver and USBserial stuff seem to be the same in 2.6.0-test1 but the ppp stuff is quite different.

Does anyone know if the ppp stuff is significantly altered?

the problem seems to be that synce can make a connection but that data does not flow. on 2.5.70 all is fine and the connection can be made and authenticated.

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with ketchup.
