Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280754AbRKBSA0>; Fri, 2 Nov 2001 13:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280753AbRKBSAR>; Fri, 2 Nov 2001 13:00:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42503 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280752AbRKBSAD>; Fri, 2 Nov 2001 13:00:03 -0500
Subject: Re: Via onboard audio
To: elanthis@awesomeplay.com (Sean Middleditch)
Date: Fri, 2 Nov 2001 18:06:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1004723462.4883.12.camel@smiddle> from "Sean Middleditch" at Nov 02, 2001 12:51:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zii5-00037A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, will do that.  RedHat uses your kernel trees, right?  I'll download
> new RPM's from rawhide if they're there (I'm in no hurry.)

Both Linus and -ac current trees support

make config
make rpm

rpm -Ivh blah...

then edit your lilo/grub config 8)
