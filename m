Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131336AbRCHMEW>; Thu, 8 Mar 2001 07:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131337AbRCHMEM>; Thu, 8 Mar 2001 07:04:12 -0500
Received: from sv.moemoe.gr.jp ([211.10.15.35]:22541 "HELO mail.moemoe.gr.jp")
	by vger.kernel.org with SMTP id <S131336AbRCHMEG>;
	Thu, 8 Mar 2001 07:04:06 -0500
Date: Thu, 08 Mar 2001 21:03:38 +0900
From: Keitaro Yosimura <ramsy@10art-ni.co.jp>
To: mvw@planets.elm.net
Subject: quota on 32bit-uid patch
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010308205016.C2F4.RAMSY@10art-ni.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco van Wieringen, Linus, and any hackers.

I've ported my quota patches for 2.4.2.

based on 
 ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/quota-fix-2.4.0-test12-1.diff.gz
 ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/quota-patch-2.4.0-test12-1.diff.gz

You can download the patches from
http://www.moemoe.gr.jp/~ramsy/Files/Linux/quota/patch-2.4.2-ky2.patch.bz2

RedHat 7.0.X's quota are not ready for 32bit-uid.
You can download the patched rpm from...
http://www.moemoe.gr.jp/~ramsy/Files/Linux/quota/quota-2.00-3ky3.src.rpm
http://www.moemoe.gr.jp/~ramsy/Files/Linux/quota/quota-2.00-3ky3.i386.rpm
(this rpm build on RedHat-7.0.1J. please rebuild src.rpm.)

please merge the kernel&tool patchs:)

Thanks.

<|> YOSHIMURA 'ramsy' Keitaro / Japan Linux Association
<|> mailto:ramsy@linux.or.jp
<|> http://jla.linux.or.jp/index.html

