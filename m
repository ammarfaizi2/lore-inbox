Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129989AbRBACyZ>; Wed, 31 Jan 2001 21:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbRBACyO>; Wed, 31 Jan 2001 21:54:14 -0500
Received: from mail.inconnect.com ([209.140.64.7]:15765 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S129250AbRBACyC>; Wed, 31 Jan 2001 21:54:02 -0500
Date: Wed, 31 Jan 2001 19:54:01 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 FireWire compile problem
In-Reply-To: <Pine.SOL.4.30.0101311945581.28765-100000@ultra1.inconnect.com>
Message-ID: <Pine.SOL.4.30.0101311953190.28765-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson said once upon a time (Wed, 31 Jan 2001):

>
> # IEEE 1394 (FireWire) support
> CONFIG_IEEE1394=y
> # CONFIG_IEEE1394_PCILYNX is not set
> CONFIG_IEEE1394_OHCI1394=y
> CONFIG_IEEE1394_VIDEO1394=y
> CONFIG_IEEE1394_RAWIO=y
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set

I noticed when I compile everything modular, there are no problems.

Dax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
