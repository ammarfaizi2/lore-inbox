Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSCPFXj>; Sat, 16 Mar 2002 00:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293716AbSCPFX3>; Sat, 16 Mar 2002 00:23:29 -0500
Received: from [203.162.56.202] ([203.162.56.202]:65515 "HELO
	mail.vnsecurity.net") by vger.kernel.org with SMTP
	id <S293713AbSCPFXU>; Sat, 16 Mar 2002 00:23:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: MrChuoi <MrChuoi@yahoo.com>
Reply-To: MrChuoi@yahoo.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
Date: Sat, 16 Mar 2002 12:33:03 +0700
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16lgjZ-0002Uh-00@the-village.bc.nu>
In-Reply-To: <E16lgjZ-0002Uh-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020316052309.9B9F44E51A@mail.vnsecurity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there are something wrong in MM of -ac tree. I can't build & run my
project (~100 source files) from inside JBuilder4 anymore. JBuilder always
reports that "cannot allocate memory".

My system:
CPU: K6-III 500Mhz
Mem: 128Mb
Swap: 64Mb
Linux From Scratch 3.1

Tested with:
2.4.19-pre3: OK
2.4.19-pre2-ac4: cannot allocate memory
2.4.19-pre3-ac1: cannot allocate memory
2.4.19-pre2aa*: OK
2.4.19-pre3aa*: OK

Regards,

MrChuoi
