Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWEPPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWEPPCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEPPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:02:52 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25216 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751202AbWEPPCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:02:51 -0400
Message-ID: <4469E998.9060303@garzik.org>
Date: Tue, 16 May 2006 11:02:48 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>	 <446914C7.1030702@garzik.org>	 <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>	 <44694C4F.3000008@garzik.org> <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
In-Reply-To: <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> 
> 
>> Can you configure your interrupts so that ethernet and SATA are not on
>> the same irq?
> 
> Sorry, need a little hand holding here. I'm unsure how to do such a
> thing, and can't really google that.

It will be in your BIOS setup somewhere.  Hopefully.

	Jeff



