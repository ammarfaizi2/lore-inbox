Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSAFLb2>; Sun, 6 Jan 2002 06:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287831AbSAFLbS>; Sun, 6 Jan 2002 06:31:18 -0500
Received: from hirogen.kabelfoon.nl ([62.45.45.69]:58892 "HELO
	hirogen.kabelfoon.nl") by vger.kernel.org with SMTP
	id <S287816AbSAFLbF>; Sun, 6 Jan 2002 06:31:05 -0500
Message-ID: <004a01c196a5$91964840$73552d3e@kabelfoon.nl>
From: "Stepan Hluchan" <stepan@3amp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17 - hang after 'freeing unused kernel memory'
Date: Sun, 6 Jan 2002 12:30:39 +0100
Organization: 3 AM Productions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have installed the RedHat 7.2 distro (I think it comes with
2.4.10-something
but that hangs too) on one machine A. and then transferred the HD to
another (machine B) where it should be used.   On machine A (Celeron 800Mhz)
it all boots up fine with any kernel, on machine B (P75 @ 100Mhz, ancient
BIOS
and mobo) it hangs after the message 'freeing up XX k unused kernel memory'.

I have compiled the 2.4.17, 2.4.0 kernels set to 'classic pentium', but both
would
hang...

What can be the cause for this?  (keep in mind it works fine on the newer
machine)

Thanks in advance,

Stepan


:: stepan hluchan
--------------------------------------------------------
p :  +31.(0)626.126.308
e :  stepan@3amp.com
i  :  http://stepan.3amp.com/
Gallery - http://stepan.3amp.com/gallery/
--------------------------------------------------------

