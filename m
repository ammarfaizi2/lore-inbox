Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTFHRja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 13:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTFHRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 13:39:30 -0400
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:19985
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id S263590AbTFHRj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 13:39:29 -0400
Message-ID: <3EE3780B.E698A892@justirc.net>
Date: Sun, 08 Jun 2003 13:53:15 -0400
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.21-rc7 sound glitching with via82cxxx
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
I ompiled and tested rc7 last night and got some interesting results
with sound..
anything that plays audio whether its an mp3 player, game, ect ect. have
an unusual delay.
it plays bits and pieces of audio usually advancing rapidly thru the
wave or mp3.
each pop will make it skip about 2-4 seconds ahead, kinda like hitting
the fast forward button on a cd player.
this same hardware works with alsa.
hope this is of any help to anyone.
one last question: is there an adsp device planned for this driver?
we could use some more sound devices to use in gaming with teamspeak +
game.
thanks!
--
Regards,
Mark Rutherford
mark@justirc.net

PGP key: http://www.justirc.net/~mark/markrutherford.asc
fingerprint: 1CF2 6229 306D A2C8 2C89  46BE FFD6 D910 5170 4FA9


