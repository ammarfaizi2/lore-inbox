Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275734AbRJFVGf>; Sat, 6 Oct 2001 17:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275739AbRJFVGZ>; Sat, 6 Oct 2001 17:06:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275734AbRJFVGL>; Sat, 6 Oct 2001 17:06:11 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
To: ebiederman@uswest.net (Eric W. Biederman)
Date: Sat, 6 Oct 2001 22:11:55 +0100 (BST)
Cc: jdthood@mail.com (Thomas Hood), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <m1bsjky3l3.fsf@frodo.biederman.org> from "Eric W. Biederman" at Oct 06, 2001 01:24:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pyjj-0002Kn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have any insite into what needs to be done so that the kernel
> will automatically configure isa pnp devices?

We already configure isapnp devices. We don't yet configure all the PnPbios
devices
