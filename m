Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTFBIKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 04:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTFBIKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 04:10:40 -0400
Received: from [62.67.222.139] ([62.67.222.139]:28121 "EHLO kermit")
	by vger.kernel.org with ESMTP id S262023AbTFBIKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 04:10:39 -0400
Date: Mon, 2 Jun 2003 10:23:33 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: weird keyboard with 2.5.70
Message-ID: <20030602082333.GA12502@synertronixx3>
Reply-To: konsti@ludenkalle.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning :)

I tried it out here at work on an 
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)

I plugged out the usb keyboard (here I have one), put the usb to ps2
adapter on it and used it as an ps2 keyboard (yes, I hotplugged again).
after a couple of minutes the ENTER key "hung" and stopped repeating
after hitting it again.

Here with this mainboard I experienced this behaviour with 2.4.x kernel
series before, though.

At home on i845PE 2.5.70-mm3 triggers this behaviour.
May a XFree86 Bug is triggered? IIRC there was something discovered
which is not fixed yet, I am searching this thing ATM...

Konsti

-- 
2.5.69-mm7
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 46 min, 1
