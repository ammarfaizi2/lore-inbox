Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268815AbTBZQio>; Wed, 26 Feb 2003 11:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268816AbTBZQio>; Wed, 26 Feb 2003 11:38:44 -0500
Received: from [202.109.126.231] ([202.109.126.231]:10598 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S268815AbTBZQin>; Wed, 26 Feb 2003 11:38:43 -0500
Message-ID: <3E5CEF17.4C014A4C@mic.com.tw>
Date: Thu, 27 Feb 2003 00:45:11 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
Reply-To: rain.wang@mic.com.tw
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: zh, en, zh-TW, zh-CN
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: system hang on HDIO_DRIVE_RESET! help!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 16:41:53.0843 (UTC) FILETIME=[F7F1C030:01C2DDB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I did HDIO_DRIVE_RESET ioctl, but system hung without any response,
only printed some mesages from kernel(v2.4.20):

hda: DMA disabled
hda: ide_set_handler: handler not null; old=c01ce300, new=c01d4400
bug: kernel timer added twice at c01ce102

     would you please help me with it?

Regards
rain.w




