Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSGAU0d>; Mon, 1 Jul 2002 16:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSGAU0c>; Mon, 1 Jul 2002 16:26:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22277 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316491AbSGAU0b>;
	Mon, 1 Jul 2002 16:26:31 -0400
Message-ID: <3D20BB85.7030504@mandrakesoft.com>
Date: Mon, 01 Jul 2002 16:28:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Axel Siebenwirth <axel@hh59.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.24] RTL8139: ioctl(SIOCGIFHWADDR): No such device
References: <20020701202026.GA896@neon.hh59.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Siebenwirth wrote:
> Have not tried 2.5.23 but 2.5.22 works fine. Since there have been changes to 
> the 8139too driver I guess thats it. Unfortunately I do not know where to fix
> this.


None that should affect this, however.

Can you please copy your 2.5.22 drivers/net/8139too.c into 2.5.24, and 
test 2.5.24 with the older driver?

	Jeff




