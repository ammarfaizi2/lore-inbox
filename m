Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUJKPxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUJKPxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUJKPxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:53:37 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:59875 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269080AbUJKPxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:53:07 -0400
Message-ID: <416AAC5F.7020109@ens-lyon.fr>
Date: Mon, 11 Oct 2004 17:53:03 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-RAM [was Re: Totally broken PCI PM calls]
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org> <20041011145628.GA2672@elf.ucw.cz>
In-Reply-To: <20041011145628.GA2672@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which machine is that, btw? Evo N620c has probably BIOS/firmware bug
> that kills machine on attempt to enter S3 or S4. It takes pressing
> power button 3 times (!) to get machine back.
> 								Pavel

Hi,

On my N600c, suspend-to-RAM seems to complete... but when I try to wake 
up the laptop (by pressing the power button), it blinks strangely and 
then immediately shutdowns instead of resuming...

Brice
