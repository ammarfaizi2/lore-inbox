Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270042AbRHGCcL>; Mon, 6 Aug 2001 22:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270044AbRHGCcB>; Mon, 6 Aug 2001 22:32:01 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:13065 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S270041AbRHGCbu>; Mon, 6 Aug 2001 22:31:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: tulip driver problem
Reply-To: klink@clouddancer.com
Message-Id: <20010807023200.0E3D2784C1@mail.clouddancer.com>
Date: Mon,  6 Aug 2001 19:32:00 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, Tom Rini wrote:
>
>On Mon, Aug 06, 2001 at 12:19:10PM -0400, Albert D. Cahalan wrote:
>
>> This is the Force PowerCore 6750 single-board computer with
>> a PowerPC processor and the DEC 21143 Ethernet chip.
>
>Just wondering, but when booting 2.4.x, do you see something like:
>"Unknown bridge resource %d: assuming transparent"
>for the tulip?
>

Linux ns1.clouddancer.com 2.4.8-pre4 #3 SMP Sat Aug 4 12:32:55 PDT 2001 i686 unknown
...
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
...
Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #0 config 1000 status 782d advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0xb400, 00:80:C8:45:97:AF, IRQ 12.


It's been working fine here, 3 cards over 2 computers.



-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."
