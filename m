Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263104AbSJGPgA>; Mon, 7 Oct 2002 11:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263097AbSJGPgA>; Mon, 7 Oct 2002 11:36:00 -0400
Received: from cynaptic.com ([128.121.116.181]:15881 "EHLO cynaptic.com")
	by vger.kernel.org with ESMTP id <S263104AbSJGPfx>;
	Mon, 7 Oct 2002 11:35:53 -0400
From: "Effrem Norwood" <enorwood@effrem.com>
To: <linux-kernel@vger.kernel.org>
Subject: strange frequent message
Date: Mon, 7 Oct 2002 08:41:32 -0700
Message-ID: <CFEAJJEGMGECBCJFLGDBAEAFCFAA.enorwood@effrem.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm using a 2.4.18 kernel with QLogic 6.1 Beta 5 qlaxxxx drivers patched in
and compiled as part of the kernel rather than as a module. Dual Xeon 2.4,
2.0GB ram, highmem enabled (4GB), SuperMicro MB. ACPI is disabled on the MB
as well as in the kernel.

I keep getting these weird messages:

"Uhhuh. NMI received for unknown reason 2c. Dazed and confused, but trying
to continue Do you have a strange power saving mode enabled?"

"Uhhuh. NMI received for unknown reason 3c. Dazed and confused, but trying
to continue Do you have a strange power saving mode enabled?"

Any ideas why this is happening?

Please cc me on replies to this as the list volume is too great for me to
subscribe.

My thanks,

Eff Norwood


