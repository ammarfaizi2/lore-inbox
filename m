Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282166AbRKWPI0>; Fri, 23 Nov 2001 10:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282165AbRKWPIR>; Fri, 23 Nov 2001 10:08:17 -0500
Received: from [216.191.235.254] ([216.191.235.254]:13325 "HELO
	bugs.dinmar.com") by vger.kernel.org with SMTP id <S282166AbRKWPID>;
	Fri, 23 Nov 2001 10:08:03 -0500
From: "Norm Dressler" <ndressler@dinmar.com>
To: <linux-kernel@vger.kernel.org>
Subject: Sparc64 Compiles OK, but won't boot new kernel
Date: Fri, 23 Nov 2001 10:09:29 -0500
Message-ID: <002101c17430$d94b2f80$3828a8c0@ndrlaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2605
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been able to successfully compile the 2.4.14 and 2.4.15 kernels
for Sparc64 but each gives me an error on boot-up:

Image to large for Destination  (twice)

It then kicks me back to the silo prompt.  My kernel is trimmed back
quite a bit and there isn't a lot there.  

It's not a compressed kernel -- should it be?  How do I do that since
the bzImage make is missing from the Sparc64 makefiles?

I am using Redhat 6.2 on an Enterprise 4000, 4 Ultrasparc-II CPU's and
2Gb of Ram.

Any suggestions??

Norm

