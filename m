Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRLLKsr>; Wed, 12 Dec 2001 05:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277713AbRLLKsi>; Wed, 12 Dec 2001 05:48:38 -0500
Received: from boden.synopsys.com ([204.176.20.19]:46765 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S274862AbRLLKsX>; Wed, 12 Dec 2001 05:48:23 -0500
From: "Alex Riesen" <riesen@synopsys.COM>
To: "Anton Altaparmakov" <aia21@cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: iproute2
Date: Wed, 12 Dec 2001 11:48:12 +0100
Message-ID: <HKEMJNBMMEMMAEHPEBGNIEGCCBAA.riesen@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i've just downloaded iproute2-2.4.7-now-ss010824.tar.gz.
But the 'ip' utility from the archive doesn't work with
my 2.4.17-pre6. Netlink is compiled in (no emulation device),
and opening the socket succeeds. But all requests (sendto's
in libnetlink) to the driver get ECONNREFUSED.
I tried 'ip link show'.
Did i got an incorrect tarball or the thing is really broken?
Btw where the contemporary iproute2 package can be found?

-alex
