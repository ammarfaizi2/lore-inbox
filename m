Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264157AbRFFVGc>; Wed, 6 Jun 2001 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264159AbRFFVGW>; Wed, 6 Jun 2001 17:06:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264157AbRFFVGO>; Wed, 6 Jun 2001 17:06:14 -0400
Subject: Re: temperature standard - global config option?
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 6 Jun 2001 22:04:08 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davidw@apache.org (David N. Welton),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010606224528.A2237@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Jun 06, 2001 10:45:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157kTI-0000RW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The spec is farenheit
> What specs?

The spec for watchdog/temperature monitor devices (/dev/temperature)

> ACPI specs use K *0.1, I'd prefer that.				Pavel

For new stuff - for ACPI etc definitely
