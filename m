Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRK2MEp>; Thu, 29 Nov 2001 07:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283192AbRK2MEf>; Thu, 29 Nov 2001 07:04:35 -0500
Received: from pollux.et6.tu-harburg.de ([134.28.85.242]:45068 "HELO
	mail.et6.tu-harburg.de") by vger.kernel.org with SMTP
	id <S276759AbRK2MEW>; Thu, 29 Nov 2001 07:04:22 -0500
Message-ID: <3C0624C3.E7A6809A@writeme.com>
Date: Thu, 29 Nov 2001 13:06:27 +0100
From: Thomas Mueller <Th.Mueller@writeme.com>
X-Mailer: Mozilla 4.05 [de]C-NECCK  (Win95; I)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: i2o and Promise SuperTrak SX6000 ata raid controller
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got quite the same problem, but it's not as simple as vojtech said.

I have, of course, switched the controller mode to 'other OS' and the
controller is being recognized by the system. Everything is fine as long
as I use kernel 2.4.4, the raid array is being recognized and working.
Whenever I switch to 2.4.13-ac8, 2.4.14 or 2.4.15-pre7 the system
freezes with kernel panic, so there seems to be a problem with current
kernels.
Any suggestions ???

Thanks,

Thomas

