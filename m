Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268381AbRGXRdm>; Tue, 24 Jul 2001 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268384AbRGXRdc>; Tue, 24 Jul 2001 13:33:32 -0400
Received: from [145.254.150.103] ([145.254.150.103]:2308 "HELO
	ozean.schottelius.org") by vger.kernel.org with SMTP
	id <S268383AbRGXRdT>; Tue, 24 Jul 2001 13:33:19 -0400
Message-ID: <3B5DB131.D16B9826@pcsystems.de>
Date: Tue, 24 Jul 2001 19:32:33 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]: control pcspeaker
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



Hello Guys!

After some modifcations here is the final (small) patch.

You can turn on and off the pcspeaker using sysctl calls:

echo 0 > /proc/sys/kernel/pcspeaker # off

echo 1 > /proc/sys/kernel/pcspeaker # on

Alan or Linus, can / will you include this in one of the next releases?

Nico


