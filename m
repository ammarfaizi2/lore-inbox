Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265411AbTFMPSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbTFMPSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:18:32 -0400
Received: from gprs20.vodafone.hu ([80.244.97.70]:1134 "EHLO kian.localdomain")
	by vger.kernel.org with ESMTP id S265411AbTFMPSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:18:31 -0400
Subject: Promise PDC20376 & driver
From: Krisztian VASAS <iron@ironiq.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1055518271.1327.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Jun 2003 17:31:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

I've read the thread here and the kernel-traffic about the Promise
Fasttrack PDC20376 (or known as Fasttrack S150 TX2plus) driver.

Well, I've got an ASUS A7V8X maindboard with this on-board SATA
controller and I've heard, that there's support for this in the FreeBSD
kernel.
I've tried it and this information was true. The controller works, I can
mount partitions on this controller without any mistake.

But!

I doesn't know the C language, so I can't port into the kernel.

So. Can anyone port the driver from FreeBSD?

Thanx for the answer.


Krisztian VASAS, 
alias IroNiQ


P.S.: please CC the answer, because I'm not member.
-- 
Web: http://ironiq.hu
E-mail: iron@ironiq.hu

