Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135255AbRDLSeQ>; Thu, 12 Apr 2001 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbRDLSd5>; Thu, 12 Apr 2001 14:33:57 -0400
Received: from [202.77.223.60] ([202.77.223.60]:48402 "HELO server.achan.com")
	by vger.kernel.org with SMTP id <S135255AbRDLSdp>;
	Thu, 12 Apr 2001 14:33:45 -0400
Message-ID: <005c01c0c37f$0431a840$5a158640@nien.sjc.wayport.net>
From: "Andrew Chan" <achan@achan.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14mwEf-00042b-00@the-village.bc.nu>
Subject: Re: i2o & Promise SuperTrak100
Date: Fri, 13 Apr 2001 02:33:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While you are at it, can you bug them for FastTrak (the software RAID thing)
support?

Their drivers are ages behind and Andre doesn't seem to be able to get them
cooperate either.

I have many many boards with their FastTrak chip on and I cannot use it
either as FastTrak or even simple ATA100 controller. I'd happy if I can use
it even as simple ATA100 controller.

Andrew Chan

==

Alan Cox says:

I've been talking constructively to promise about the i2o on the supertrak
not working straight off with the kernel i2o driver. Currently it looks
promising


