Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVB1OSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVB1OSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVB1ORI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:17:08 -0500
Received: from smtp2.volja.net ([217.72.64.60]:15113 "EHLO smtp2.volja.net")
	by vger.kernel.org with ESMTP id S261630AbVB1ON5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:13:57 -0500
Message-ID: <1109599986.422326f240b1b@webmail.volja.net>
Date: Mon, 28 Feb 2005 15:13:06 +0100
From: robinud@volja.net
To: linux-kernel@vger.kernel.org
Subject: Multichannel audio ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5 / FreeBSD-5.2.1
X-Originating-IP: 213.253.102.145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

How does one use the extra channels on a six channel card ?
I can only hear the 2 front speakers.

I remember on a es1370 card, that I had an extra /dev/dsp1 for the rear speaker
pair, but with an on board VIA audio there is only one /dev/dsp.

I also tried playing a 6 channel sound file with sox, but still only the front
speakers make sound.

Any clues ?

HW is VIA 8235 + Realtek ALC650
kernel 2.6.8-debian
driver is OSS via82xxxx ( I'm willing to switch to ALSA, but a quick look says
it is the same there ).

Ideally I would want a second stereo /dev/dsp1, that would produce sound on the
rear speakers.

Thanks for any help,
David

----------------------------------------------------------------
Varno. Enostavno. Vredno. Internet dodatne storitve.
http://www.voljatel.si/storitve/

