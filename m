Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRB1HQk>; Wed, 28 Feb 2001 02:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130094AbRB1HQa>; Wed, 28 Feb 2001 02:16:30 -0500
Received: from alto.i-cable.com ([210.80.60.4]:20868 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S130079AbRB1HQL>;
	Wed, 28 Feb 2001 02:16:11 -0500
Message-ID: <3A9CA5C2.936334A6@hkicable.com>
Date: Wed, 28 Feb 2001 15:16:18 +0800
From: Thomas Lau <lkthomas@hkicable.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Report bug in kernel 2.4.x:
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, someone using ne2000 chipset have same problem-----drop connection

some people already post in mail list, but the sound like no one
interested about our problem

it will auto drop connection when used a long time ( over 24 hours )
I can not use ifconfig to restart the interface, so I must reboot the
kernel ( system )
I didn't reach this problem before, but in 2.4.x, I hope it will fix
soon and please help us to fix
my system config:
Cable modem
NE2000-PCI
problem type:
connection drop when used over 24 hours or more



Thanks

