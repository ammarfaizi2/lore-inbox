Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282418AbRLWOIR>; Sun, 23 Dec 2001 09:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLWOIH>; Sun, 23 Dec 2001 09:08:07 -0500
Received: from d101.x-mailer.de ([212.162.12.2]:4578 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id <S282418AbRLWOH6>;
	Sun, 23 Dec 2001 09:07:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gietl <a.gietl@e-admin.de>
To: linux-kernel@vger.kernel.org
Subject: serial console on > 2.4.14
Date: Sun, 23 Dec 2001 15:06:58 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16I9Fq-0007yj-00@d101.x-mailer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i am exploring problems on linux-smp kernels (did not test single-processor) 
with version greater 2.4.14. In Fact i just tested 2.4.16 and 2.4.17.

Here's my problem:

I compiled all kernels with the same configuration with serial console-option 
enabled. With 2.4.14 everything is just fine: I see the kernel-output and can 
type in things during startup esp. do a fsck. With 2.4.16 and 2.4.17 i SEE 
everything but no input is accepted.

Did you break anything in 2.4.15 or 2.4.16. I of course did not test 2.4.15 
because of the fs-bug.

I will of course provide any information you request.

thanx

andreas
-- 
e-admin internet gmbh
Andreas Gietl
Roter-Brach-Weg 124a
tel +49 941 3810884
fax +49 941 3810891
mobil +49 171 6070008
