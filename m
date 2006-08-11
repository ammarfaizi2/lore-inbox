Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWHKPsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWHKPsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWHKPsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:48:43 -0400
Received: from rtr.ca ([64.26.128.89]:9447 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932156AbWHKPsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:48:42 -0400
Message-ID: <44DCA6D4.7090304@rtr.ca>
Date: Fri, 11 Aug 2006 11:48:36 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Jason Lunz <lunz@falooley.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain> <p733bc5nm5g.fsf@verdi.suse.de> <1155213464.22922.6.camel@localhost.localdomain> <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex> <20060810194734.GE11829@suse.de>
In-Reply-To: <20060810194734.GE11829@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
> I'm not on any of the suspend lists, I was merely comparing the
> suspend-others or suspend-libata ration to suspend-ide on linux-kernel,
> and the latter is clearly in the minority. I've used ide suspend quite a
> bit myself, and never had issues with it (or whichever ones I saw
> initially, I fixed). Of course it depends very much on the hardware. I'd
> still say that ide suspend probably supports a much wider range of
> hardware, than does libata suspend.

Of my various notebooks over the years that used drivers/ide,
all of them work/worked perfectly with suspend/resume to RAM.

Just luck, perhaps.

Cheers
