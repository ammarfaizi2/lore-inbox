Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbVGIIRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbVGIIRL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 04:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbVGIIRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 04:17:11 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:64999 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263167AbVGIIRJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 04:17:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AXDdkjudkK8UOEC4Hd2B6wXyZh1hTTLfoSXO+Oyf1sHgmqrWrU70dTi3tL+AuMz0RIyPjnODA1RCrBKbYR0fDCcOGELFzE8xYWHK46IJrWg8057SIqSxi5shu2GzKo2kaFSceSUDAeF6SKIjSHZ3zikglyRqpnqLmfNe3IMletY=
Message-ID: <d9def9db05070901176b552f1e@mail.gmail.com>
Date: Sat, 9 Jul 2005 10:17:08 +0200
From: Rechberger Markus <mrechberger@gmail.com>
Reply-To: Rechberger Markus <mrechberger@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: v4l, terratec cinergy 250 USB
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently bought an USB TV device, which isn't really supported by
linux.. I started to dig into how to write an USB driver .. so far so
good I'm already able to enable a videostream and watch it with xine,
beside that I try to stick to the design of the driver for the
previous device release (tt cinergy 200 USB). My current problem is
how to figure out the i2c interface of the USB device (I called the
company for getting some informations but I got no response, also
wrote an email no luck either.. )
The device contains an empia 2820 chip (which has another protocol
than the em2800)...
so any idea how I can figure out the i2c device of it, or where I can
get more general informations about i2c? (I'm kinda new to it so every
information could help me at least a bit to understand more about it)

thanks

Markus
