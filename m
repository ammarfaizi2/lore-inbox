Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282890AbRLQVJo>; Mon, 17 Dec 2001 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282882AbRLQVJZ>; Mon, 17 Dec 2001 16:09:25 -0500
Received: from canardo.info.unicaen.fr ([193.55.128.18]:21519 "HELO
	canardo.info.unicaen.fr") by vger.kernel.org with SMTP
	id <S282877AbRLQVJT>; Mon, 17 Dec 2001 16:09:19 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] TEST of patch proposed for i810 audio
From: Samir Saidani <saidani@info.unicaen.fr>
Date: 17 Dec 2001 22:14:00 +0100
Message-ID: <w4ry9k1h7mv.fsf@info.unicaen.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salut,

I sum up the different thread about i810_audio
(i'm only a user testing this driver)

Doug Ledford : release 0.11 in his site
(http://people.redhat.com/dledford/i810_audio.c.gz)
don't work : cat /vmlinuz > /dev/dsp freezes the kernel,
no sound played
No possibility to Alt-SysRq


Nathan Bryant : patch for 0.11
not tested

Andris Pavenis : other patch for 0.11 (seems to be better)
not tested

Doug Ledford : patch for 0.11, 0.11 becomes 0.12
don't work, see 0.11


Andris Pavenis : patch for 0.12, 0.12 becomes 0.12a
don't work, see 0.11, one difference : sound played
and then freeze.


My system
---------
Kernel : 2.4.16
Debian unstable

++
Samir Saidani

