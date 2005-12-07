Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVLGXlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVLGXlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbVLGXlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:41:12 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:26241 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030446AbVLGXlM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:41:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VV5KohgA0uKLLTd9deVaaExi0G0GcohuoVMTYx/DRoVDFAU9ckyNU7G4E1uLB/kJlireVIL0xwU+HyG9NTdl5q2H/YCrbyM4Tjp7fG2czHm9Ofx4xNTlYeRyy+/Kpy875nrxpq+LNKvk5wlyAvFgymV9eXMi1+XlzVB3AXNal58=
Message-ID: <9e4733910512071541s1a6215d9pb166bb27e2c579f9@mail.gmail.com>
Date: Wed, 7 Dec 2005 18:41:11 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: Chase Venters <chase.venters@clientec.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133996869.544.112.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <9e4733910512060816k26e12313y6b9a943d7cce4341@mail.gmail.com>
	 <Pine.LNX.4.64.0512071538110.17767@turbotaz.ourhouse>
	 <1133996869.544.112.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-12-07 at 15:46 -0600, Chase Venters wrote:
> > bad things to allowing their competitor to take a *big* lead. Hell,
> > wasn't 3dfx's fall from power partially related to IP suits? Or
> > did I just hear that somewhere? I don't recall.
>
> If my memory still works correctly 3Dfx sued Nvidia and in the end
> Nvidia had to buy them to solve it. Patents are a big issue in the 3D
> graphics space and the 'what they can't see' approach to minimising
> lawsuits has its obvious appeal.
>
> One of the problems in this area is the big fight going on and the fact
> it is not commodity. Ten random developers are not going to produce a
> driver comparable to Nvidia's libGL in the same way that ten random
> developers can produce as good an ATA or SCSI adapter as anyone else

I do believe that patent lawsuits can be used to force hardware specs
out of everyone; all we need is for someone to donate a good patent to
get the ball rolling. Being on the receiving end of a suit like this
will suck big time. There is no good solution for the company being
attacked, cough up your hardware specs or risk an injunction that may
kill your company.

But to play fair the settlement should only ask for the specs needed
to program the hardware. It wouldn't be right to use these tactics to
force Nvidia's libGL source out of them if they didn't want to
contribute it.

Can the Linux community justify using ruthless means to force
documentation out of vendors? Asking politely doesn't seem to be
working -  I suspect it may take something of this magnitude to force
a change out of NVidia/ATI.

--
Jon Smirl
jonsmirl@gmail.com
