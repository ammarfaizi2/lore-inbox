Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbRBMXeY>; Tue, 13 Feb 2001 18:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130912AbRBMXeE>; Tue, 13 Feb 2001 18:34:04 -0500
Received: from home2.ecore.net ([212.63.128.224]:4103 "EHLO home2.ecore.net")
	by vger.kernel.org with ESMTP id <S129930AbRBMXdT>;
	Tue, 13 Feb 2001 18:33:19 -0500
Message-ID: <3A89C335.433F948@januszewski.de>
Date: Wed, 14 Feb 2001 00:28:53 +0100
From: Fabian Januszewski <fabian.linux@januszewski.de>
X-Mailer: Mozilla 4.75 [de] (X11; U; Linux 2.2.17-21mdk i586)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac11, VM: Bad swap entry
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.1-ac11 creates repeatedly the following error messages on my box:

kernel: VM: killing process crond      (or any other process)
kernel: VM: Bad swap entry 0000e200    (variable addresses)

for example in intervals of about 5 to 10 seconds. This is on a notebook, AMD
K6-433, 64megs RAM,  VIA MVP4 chipset (VT8501 revision 3), Bus Master revision
6; didn't get these errors with the 2.4.1-ac6 patch which I ran before.
