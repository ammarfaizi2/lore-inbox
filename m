Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266757AbRGKRPN>; Wed, 11 Jul 2001 13:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbRGKRPC>; Wed, 11 Jul 2001 13:15:02 -0400
Received: from 64.5.206.104 ([64.5.206.104]:39693 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S266757AbRGKROv>; Wed, 11 Jul 2001 13:14:51 -0400
Date: Wed, 11 Jul 2001 13:14:34 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: forcing irq for a particular pci device
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AE5@xsj02.sjs.agilent.com>
Message-ID: <Pine.LNX.4.33.0107111314040.13823-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, MEHTA,HIREN (A-SanJose,ex1) wrote:

> Hi List,
>
> Is there any way to force a particular irq for a particular
> pci device ?
>
> -hiren
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Try the "PCI Options" section of your computer's BIOS.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

