Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbRFBIF7>; Sat, 2 Jun 2001 04:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbRFBIFt>; Sat, 2 Jun 2001 04:05:49 -0400
Received: from TCE-E-7-182-15.bta.net.cn ([202.106.182.15]:55440 "HELO
	china.com") by vger.kernel.org with SMTP id <S262119AbRFBIFh>;
	Sat, 2 Jun 2001 04:05:37 -0400
Date: Sat, 2 Jun 2001 16:8:8 +0800
From: Qingbo Wu <wuqb@china.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: about mips linux root file system
X-mailer: FoxMail 3.0 beta 2 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20010602080540Z262119-932+3811@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I am new to this mail list. Our university are porting linux to our
mips evaluation board. There is no network card and CDROM driver
can not work under linux. But we have serail port, I can download
our modified kernel to evaluation board, and it can run, stop
at mount root file system.
I think if I can use ramdisk using serail port. I do not know
how to combine kernel image with ramdisk root file image.
And where can I get small size root file image for mipsel?
If someone knows, please help me.
Thanks in advance!

Barry

