Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264914AbRFUKJx>; Thu, 21 Jun 2001 06:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264912AbRFUKJn>; Thu, 21 Jun 2001 06:09:43 -0400
Received: from [203.126.57.231] ([203.126.57.231]:23308 "HELO
	mail.celestix.com") by vger.kernel.org with SMTP id <S264850AbRFUKJe>;
	Thu, 21 Jun 2001 06:09:34 -0400
Date: Thu, 21 Jun 2001 17:58:57 +0800
From: Thibaut LAURENT <thibaut@celestix.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.6-preX and MediaGX
Message-Id: <20010621175857.1e278b28.thibaut@celestix.com>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to build a kernel for Cyrix MediaGX. Kernel version is 2.4.6-pre3
as it comes straight from the XFS devel tree.
Processor type is set to 586/K5/5x86/6x86/6x86MX. Everything compiles fine.

Here comes my problem : the darn thing won't boot. I've seen at least 3
different behaviours after the "Uncompressing Linux... Ok, booting the kernel"
message : 
Most of the time, it just crashes, nothing special.
Sometimes, the screen blinks and turns blank (FB is not in...)
Once or twice out of 20+ times, kernel panics.

Any idea ?

If you need the kernel panic trace I can try to reproduce it, though it seems
very random.

Regards,

Thibaut

