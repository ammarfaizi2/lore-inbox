Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270806AbTGVLjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270807AbTGVLjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:39:45 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:15304 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP id S270806AbTGVLjl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:39:41 -0400
Message-ID: <3F1D2608.47618C9E@pp.inet.fi>
Date: Tue, 22 Jul 2003 14:54:48 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hielke Christian Braun <hcb@unco.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 cryptoloop & aes & xfs
References: <20030720005726.GA735@jolla> <20030720103852.A11298@pclin040.win.tue.nl> <20030720213803.GA777@jolla> <200307211312.40068.jeffpc@optonline.net> <20030722002412.GA13788@pacserv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hielke Christian Braun wrote:
> I retried today on a different spare machine with the same result.
> Then i tried with formating the loopback device with ext2
> filesystem. After filling the the device with about 1GB of data, i
> umounted it and did a file check. A lot of errors where reported.
> Something is not good there too.
> 
> Is anybody using the cryptoloop successful in 2.6.0?

loop-AES works fine with 2.6.0-test1, here:

http://loop-aes.sourceforge.net/loop-AES/loop-AES-v1.7d.tar.bz2
http://loop-aes.sourceforge.net/updates/loop-AES-v1.7d-20030714.diff.bz2

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

