Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRIQKsi>; Mon, 17 Sep 2001 06:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273566AbRIQKs2>; Mon, 17 Sep 2001 06:48:28 -0400
Received: from abel.math.tsukuba.ac.jp ([130.158.120.16]:21434 "HELO
	abel.math.tsukuba.ac.jp") by vger.kernel.org with SMTP
	id <S273565AbRIQKsZ>; Mon, 17 Sep 2001 06:48:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <michael.dreher@gmx.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.9 deadlock
Date: Mon, 17 Sep 2001 19:49:33 +0900
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010917104847.A8CABFC91@abel.math.tsukuba.ac.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

yesterday my box locked up. It happened when I opened a link in a new
window of konqueror of kde2.2.
No ping, no sysrq, no keyboard LEDs. Obviously nothing in the logs.
I had to press reset.

It is a PIII 450 Mhz with 128 MB Ram (usually 10-20 MB free), 160 MB
swap (usually 50 MB used). I have no IDE, Adaptec AIC-7881U,
DECchip 21140 ethernet card, and never had eny problems with these.

This is a 2.4.9 Kernel, patched with ext3-0.9.6.
Otherwise, this box is very solid and has never locked up before. 
2.4.5 (with ext3 patch) had an uptime of more than 70 days.
I use it as a desktop box only, and the load is light.

Sorry for this imprecise and vague description. Just ask if you need
more infos.

best regards,
Michael

 




