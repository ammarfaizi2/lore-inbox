Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWEYRsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWEYRsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWEYRsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:48:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39561 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030296AbWEYRsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:48:06 -0400
Subject: Re: OpenGL-based framebuffer concepts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jon Smirl <jonsmirl@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>, Dave Airlie <airlied@gmail.com>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <4475D3CE.3010309@grupopie.com>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>
	 <44756E70.9020207@garzik.org>
	 <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>
	 <4475C845.5000801@garzik.org>  <4475D3CE.3010309@grupopie.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 May 2006 19:01:02 +0100
Message-Id: <1148580063.12482.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-25 at 16:57 +0100, Paulo Marques wrote:
> Why is everyone so keen on keeping the video drivers crippled, but no 
> one says "ACPI should be done from user space with user mode helpers"?

Lots of people said that, and tried and it turns out you really can't
get ACPI to fly in user space without major major hackery.

Alan

