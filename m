Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTD1CA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTD1CA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:00:26 -0400
Received: from CPE00045a9153f8-CM0f0099801693.cpe.net.cable.rogers.com ([24.100.181.49]:13572
	"EHLO localhost") by vger.kernel.org with ESMTP id S263272AbTD1CAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:00:24 -0400
Message-ID: <3EAC8E29.9080007@rogers.com>
Date: Sun, 27 Apr 2003 22:12:57 -0400
From: Aravind/=?UTF-7?Q?+CQUJMAk1CT8JKAlNCSY-?= <aravind@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [CRASH] kernel 2.4.19SMP + ALSA 0.9.2
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Using ALSA 0.9.2 for OSS applications crashes Linux. Pressing the
keys Ctrl+ScrollLock dumps all the process on screen with some message 
saying [NOTLB] for all process. It is triggered while running sflaunch 
from the speakfreely-7.5 package.

The application works fine with ALSA 0.5.x series. There are no related 
or unusual messages in /var/log/messages. ALSA 0.9 has never worked for 
me and every time I try to test a new release of ALSA 0.9, I am forced 
to go back to 0.5 as I use speakfreely.

My system configuration is
Kernel: 2.4.19 SMP
ALSA driver: 0.9.2
ALSA lib: 0.9.2
ALSA utils:0.9.2
GCC: 2.96-85
GLIBC: 2.2.93-5
SoundCard: ESS Maestro 2E
SoundCard Driver: snd-card-es1968.o

Regards

Aravind

-- 
....................................................................
PGP KeyID: 52C72E39
     Fingerprint: 0A03 2FC7 D478 880D D2BB  67F8 9072 B974 52C7 2E39
....................................................................

