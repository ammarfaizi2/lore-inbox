Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRAPMmM>; Tue, 16 Jan 2001 07:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130090AbRAPMmC>; Tue, 16 Jan 2001 07:42:02 -0500
Received: from smtp.alcove.fr ([212.155.209.139]:21267 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S130013AbRAPMlv>;
	Tue, 16 Jan 2001 07:41:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0+aic7xxx doesn't boot, 2.2.17 neither
In-Reply-To: <14948.13544.776999.735127@ravan.camtp.uni-mb.si>
In-Reply-To: <14948.13544.776999.735127@ravan.camtp.uni-mb.si>
Reply-To: julien23@alcove.fr
From: Julien Gaulmin <julien23@alcove.fr>
Organization: Alcove
Message-Id: <E14IVQq-0007iW-00@morgan.alcove-int>
Date: Tue, 16 Jan 2001 13:41:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, you wrote:
> Intel C440GX+ with on-board Adaptec AIC-7896 fails to boot 2.4.0:
>
> SCSI bus is being reset for host 0 channel 0
> SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
> ... ad infinitum ...
>
> In contrast, this is what I get from the 2.2.17 boot:

I've got the same problem with the same hardware _but_ on 2.2.17
although 2.0.96 used to work fine.

Can I have your .config and your AIC firmware version in order to make a
little comparison.

Any other idea about the problem?

julien
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
