Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbUBGM5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 07:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbUBGM5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 07:57:33 -0500
Received: from fep05.swip.net ([130.244.199.133]:56010 "EHLO
	fep05-svc.swip.net") by vger.kernel.org with ESMTP id S265549AbUBGM5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 07:57:32 -0500
From: jjluza <jjluza@free.fr>
Reply-To: jjluza@free.fr
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.6.3-rc1: No sound with nforce2 sound system
Date: Sat, 7 Feb 2004 13:57:35 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402071357.35566.jjluza@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an nforce2 motherboard with the sound module snd_intel8x0.
I had no problem with sound with kernel 2.6.2-bk2.
But now, aplay doesn't work anymore, enemy-territory too.
Other programs like xmms, kde apps using arts, and play still works.
I get an error message with enemy-territory :
> /dev/dsp: Input/output error
> Could not mmap /dev/dsp
