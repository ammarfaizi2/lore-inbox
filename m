Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbTFCOya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbTFCOy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:54:29 -0400
Received: from bork.hampshire.edu ([206.153.194.35]:23262 "EHLO
	bork.hampshire.edu") by vger.kernel.org with ESMTP id S265036AbTFCOy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:54:28 -0400
Date: Tue, 3 Jun 2003 11:07:53 -0400 (EDT)
From: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
X-X-Sender: josiah@bork.hampshire.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver status
In-Reply-To: <1054648192.9234.24.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306031107350.22515-100000@bork.hampshire.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I just tried -ac2 and it does the same thing :)
	-Josiah

On 3 Jun 2003, Alan Cox wrote:

On Maw, 2003-06-03 at 15:11, Wm. Josiah Erikson wrote:
> Is there some silly hack I can do to the driver code to force all devices 
> to DMA on bootup? Everything works fine except for that. I'm using 
> 2.4.21-rc6-ac1

-ac2 knows the firmware doesn't intialise DMA mode and shouldn't be used
as a safety guide.



