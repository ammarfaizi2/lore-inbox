Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTEVQZB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTEVQZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:25:00 -0400
Received: from [208.186.192.194] ([208.186.192.194]:50113 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262771AbTEVQY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:24:59 -0400
Date: Thu, 22 May 2003 09:38:55 -0700 (PDT)
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
In-Reply-To: <20030522163448.GA17004@ranty.ddts.net>
Message-ID: <Pine.LNX.4.44.0305220937370.5889-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Sorry. Since it is small I'll simply split class-casts+release.diff and
>  attach both pieces just in case.

Thanks.

>  If I had to choose I would take drivers/base/firmware/

Ok. Maybe I mis-read that part of the patch; I thought there was more than 
one file. No worries, then. 


	-pat

