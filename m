Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280052AbRKITej>; Fri, 9 Nov 2001 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280064AbRKITe3>; Fri, 9 Nov 2001 14:34:29 -0500
Received: from boden.synopsys.com ([204.176.20.19]:14785 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S280052AbRKITeV>; Fri, 9 Nov 2001 14:34:21 -0500
Date: Fri, 9 Nov 2001 20:31:33 +0100
From: root <root@bilbo.gr05.synopsys.com>
Message-Id: <200111091931.fA9JVXif001648@bilbo.gr05.synopsys.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x: AT Keyboard not present?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

>From time to time I experience that my mouse pointer blocks for a few 
seconds, the stuff that I type is ignored, etc. 'grep keyboard' in my 
syslog files returns:

Nov  2 20:27:36 bilbo kernel: keyboard: Timeout - AT keyboard not present?(ed)
Nov  2 20:55:12 bilbo kernel: keyboard: Timeout - AT keyboard not present?(00)
Nov  3 08:10:28 bilbo kernel: keyboard: Timeout - AT keyboard not present?(ed)
Nov  4 15:20:51 bilbo kernel: keyboard: Timeout - AT keyboard not present?(ed)
Nov  4 15:33:07 bilbo kernel: keyboard: Timeout - AT keyboard not present?(01)
Nov  5 18:01:29 bilbo kernel: keyboard: Timeout - AT keyboard not present?(01)
Nov  5 21:39:36 bilbo kernel: keyboard: Timeout - AT keyboard not present?(ed)
Nov  5 22:19:59 bilbo kernel: keyboard: Timeout - AT keyboard not present?(00)
Nov  6 18:58:33 bilbo kernel: keyboard: Timeout - AT keyboard not present?(00)
Nov  6 20:41:48 bilbo kernel: keyboard: Timeout - AT keyboard not present?(01)
Nov  6 20:46:53 bilbo kernel: keyboard: Timeout - AT keyboard not present?(00)
Nov  7 19:56:34 bilbo kernel: keyboard: Timeout - AT keyboard not present?(ed)
Nov  9 20:18:31 bilbo kernel: keyboard: Timeout - AT keyboard not present?(01)

Pretty strange, isn't it? What is the story here?


Regards

Harri
