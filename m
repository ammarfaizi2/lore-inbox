Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271706AbRHQRal>; Fri, 17 Aug 2001 13:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271696AbRHQRaa>; Fri, 17 Aug 2001 13:30:30 -0400
Received: from femail48.sdc1.sfba.home.com ([24.254.60.42]:2751 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271706AbRHQRaO>; Fri, 17 Aug 2001 13:30:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steve Snyder <swsnyder@home.com>
Reply-To: swsnyder@home.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: MTRR/DRM questions
Date: Fri, 17 Aug 2001 12:30:18 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081712301804.01709@mercury.snydernet.lan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. Is there any benefit to enabling MTRR support for systems (RedHat v7.1 / 
kernel v2.4.9) that will never run a graphical user interface?  Usually I 
read of MTRR-related matters in the context of GUI acceleration.  Would my 
text-only system benefit from MTRR support?

2. The kernel doc says the DRM support is avalable for the Intel 440LX 
chipset, but no mention is made of the 440EX.  Given that the 440EX is 
kinda-sorta similar to the 440LX, can I assume that the EX chipset is also 
supported?

Please CC me as I am not subscribed to the list.

Thanks.
