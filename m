Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOQrK>; Wed, 15 Nov 2000 11:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKOQrA>; Wed, 15 Nov 2000 11:47:00 -0500
Received: from et-gw.etinc.com ([207.252.1.2]:19462 "EHLO etinc.com")
	by vger.kernel.org with ESMTP id <S129045AbQKOQq5>;
	Wed, 15 Nov 2000 11:46:57 -0500
Message-Id: <5.0.0.25.0.20001115111100.03572eb0@mail.etinc.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Wed, 15 Nov 2000 11:15:21 -0500
To: R.E.Wolff@BitWizard.nl (Rogier Wolff), linux-kernel@vger.kernel.org
From: Dennis <dennis@etinc.com>
Subject: Re: 2.4. continues after Aieee...
In-Reply-To: <200011150753.IAA05451@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:53 AM 11/15/2000, Rogier Wolff wrote:

>Shouldn't the system be "halted" after an "Aiee, killing interrupt
>handler"?
>

This brings another question. Has there been any work done to force linux 
to reboot on all panics? Linux's propensity to crash drivers (say the 
network card driver) and leave the system running make linux unusable in 
unattended environments as the machine is functionally dead.

a simple switch that forces reboot on panic would do much to alleviate the 
problem.

DB

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
