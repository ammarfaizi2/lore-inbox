Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSA0T2c>; Sun, 27 Jan 2002 14:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288414AbSA0T2W>; Sun, 27 Jan 2002 14:28:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24841 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288452AbSA0T2M>; Sun, 27 Jan 2002 14:28:12 -0500
Subject: Re: [PATCH] 2.4.18-pre6 AGP enable fixes
To: bjorn_helgaas@hp.com (Bjorn Helgaas)
Date: Sun, 27 Jan 2002 19:40:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        dri-devel@lists.sourceforge.net, bjorn_helgaas@hp.com (Bjorn Helgaas)
In-Reply-To: <20020123204523.04A764556@ldl.fc.hp.com> from "Bjorn Helgaas" at Jan 23, 2002 01:46:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UvAZ-0002Hu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there anything gained by checking the device class before looking
> for the AGP capability?  The "agp_find_cap" patch attached implements
> this idea.  I've compiled and booted kernels with both patches, but
> they're otherwise untested.

Just caution about not twiddling stuff we shouldnt touch. 

Alan
