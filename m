Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbRDCTJ1>; Tue, 3 Apr 2001 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRDCTJQ>; Tue, 3 Apr 2001 15:09:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21768 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132434AbRDCTJF>; Tue, 3 Apr 2001 15:09:05 -0400
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted due to
To: miles@megapathdsl.net (Miles Lane)
Date: Tue, 3 Apr 2001 20:10:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net (David Brownell)
In-Reply-To: <3ACA0C83.1E5A6020@megapathdsl.net> from "Miles Lane" at Apr 03, 2001 10:46:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kWCc-0000EF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Brownell recently added this check to the usb-ohci driver
> since noone has gotten information from AMD for the workaround,
> which is rumored to exist, for this bug.
> 
> Do any of you have contacts within AMD who might be able to
> get an explanation of the workaround to David Brownell?

We are working on that currently via the Red Hat contact. 

> value given varies.  Rereading NDP seems to give a valid value.  
> I am not really clear why we don't simply read the value twice 
> whenever the host-controller is detected to be an AMD-756.

because we dont know the full scope of the problem yet.


