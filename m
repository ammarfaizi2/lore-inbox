Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTJaUFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 15:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbTJaUFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 15:05:44 -0500
Received: from [203.152.107.155] ([203.152.107.155]:13440 "HELO
	skieu.myftp.org") by vger.kernel.org with SMTP id S263541AbTJaUFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 15:05:43 -0500
Date: Sat, 1 Nov 2003 09:04:16 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@darkstar.example.net
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Alsa question.
Message-ID: <Pine.LNX.4.53.0311010858320.931@darkstar.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Use 2.6.0-test9-mm1 play xmms use OSS emulation sound sometimes distorted (did renice xmms to -10)
but apart from the time it got distorted, soudn quality is really good. If use
through esd the distorted is gone, but sound quality a bit worse.

The question is? How can I make xmms not distorted? SHould I specify the
option non_block mode to snd-pcm-oss? If yes how to do that as I compile alsa built
into the kernel (not a modules) so which kernel parameters do the job?

Plese CC me to haiquy@yahoo.com

Thanks


Steve Kieu

Homepage http://scorpius.spaceports.com/~skieu/

PGP Key http://scorpius.spaceports.com/~skieu/steve-pub.key

