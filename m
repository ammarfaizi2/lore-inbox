Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTEVQho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTEVQho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:37:44 -0400
Received: from [208.186.192.194] ([208.186.192.194]:50120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262805AbTEVQhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:37:43 -0400
Date: Thu, 22 May 2003 09:51:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Manuel Estrada Sainz <ranty@debian.org>
cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <jt@hpl.hp.com>,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round
 and a halve
In-Reply-To: <20030522164349.GA17830@ranty.ddts.net>
Message-ID: <Pine.LNX.4.44.0305220950520.5889-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Actually it is two files:
> 
>  	firmware_class.c:
> 		the code itself
> 	firmware_sample_driver.c:
> 		sample code for driver writers.
> 
>  If you don't like having firmware_sample_driver.c there, it could be
>  moved to Documentation/ or put in some web page.

I'd prefer that personally, with a comment on the location in 
firmware_class.c.

Thanks,


	-pat

