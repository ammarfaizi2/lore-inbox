Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286886AbRL1Mkf>; Fri, 28 Dec 2001 07:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286878AbRL1MkZ>; Fri, 28 Dec 2001 07:40:25 -0500
Received: from [61.152.250.207] ([61.152.250.207]:6062 "HELO mail.etang.com")
	by vger.kernel.org with SMTP id <S286885AbRL1MkO>;
	Fri, 28 Dec 2001 07:40:14 -0500
Date: Fri, 28 Dec 2001 20:40:45 +0800
From: jz <jzintswift@etang.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Problem in 2.4.17 & 2.4.1 & 2.5.2-pre3
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20011228124301.237461C80DF53@mail.etang.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I had some problem in running kernel:
1)2.4.17
  When booting & runing,show the following message:
  spurious 8259A interrupt:IRQ7
2)2.5.1
  When I reboot the box, the system stop at
  Sending all processes the TERM signal...
3)2.5.2-pre3
  show the message:
  kmod failed to exec /sbin/modprobe -s -k nls-GB2312,errno=2
  Kernel panic:Out of memory and no killable proceses.

My box is  KT233 and athlon 1.2G with LFS-3.1 system(reiserfs).

            jz
            jzintswift@etang.com

