Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVDCMqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVDCMqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVDCMqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:46:13 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:18013 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261717AbVDCMqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:46:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=oZC+CgOduByy6BwpVxFvuyKr9ErLsdDs7fLLShhOLpivQlfv6mJOQLdXyRBXv2Ru/k4kKb6LY1htTFOor5mgLVOddSa0f28uttrVVx9NV5BFhoipub59bMe/J4WeFEjUEGiEXH0aJHM3bS5M2PkVS2Q149dFzvjVKnGkH2VhTUE=
Message-ID: <424FE590.5060507@gmail.com>
Date: Sun, 03 Apr 2005 14:46:08 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc1-bk does not boot x86_64
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried the recent 2.6.12-rc1-bk5 snapshot from kernel.org.
When I want to boot my x86_64 system only a green line appears on screen.
The config is the same as in 2.6.12-rc1-bk4 which works flawlessly on my
system.

I only saw the message that CPU0 and CPU1 where initialized. And then
there was
Brinnging up CPUs and it stopped.

Its an Intel Pentium4 640 with (EMT64,HT,EIST,CIE enabled).
The graphic card is an Nvidia 6600GT PCIe device.

Thanks

Best regards
