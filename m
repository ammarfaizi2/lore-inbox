Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUJKSl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUJKSl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbUJKSl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:41:26 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:55251 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269191AbUJKSko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:40:44 -0400
Message-ID: <416AD39D.2000306@ens-lyon.fr>
Date: Mon, 11 Oct 2004 20:40:29 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend-to-RAM [was Re: Totally broken PCI PM calls]
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org> <20041011145628.GA2672@elf.ucw.cz> <416AAC5F.7020109@ens-lyon.fr> <20041011161718.GA1045@elf.ucw.cz> <416ABE31.3040004@ens-lyon.fr> <20041011182309.GD1007@elf.ucw.cz>
In-Reply-To: <20041011182309.GD1007@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>* S1 seems to work.
>>* S3 is so buggy: suspend still seem to complete. Pushing the power 
>>button to resume doesn't shutdown the machine anymore: the laptop wakes 
>>up but doesn't write or do anything. I'm only able to stop it by 
>>pressing the power button.
> 
> 
> Hmm, and is the linux alive (like capslock works?) or do you need
> hard poweroff?
> 								Pavel

Hard poweroff only. capslock doesn't work.

	Thanks
	Brice
