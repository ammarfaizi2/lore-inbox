Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbSJBX21>; Wed, 2 Oct 2002 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbSJBX21>; Wed, 2 Oct 2002 19:28:27 -0400
Received: from magic.adaptec.com ([208.236.45.80]:4789 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S262687AbSJBX20>;
	Wed, 2 Oct 2002 19:28:26 -0400
Date: Wed, 02 Oct 2002 17:33:37 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jos Hulzink <josh@stack.nl>, Eriksson Stig <stig.eriksson@sweco.se>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx problems?
Message-ID: <4119940000.1033601617@aslan.btc.adaptec.com>
In-Reply-To: <20021002225057.TYEL1314.amsfep11-int.chello.nl@there>
References: <E50A0EFD91DBD211B9E40008C75B6CCA01497EDD@ES-STH-012>
 <3901880000.1033578523@aslan.btc.adaptec.com>
 <3907280000.1033578658@aslan.btc.adaptec.com>
 <20021002225057.TYEL1314.amsfep11-int.chello.nl@there>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday 02 October 2002 19:10, Justin T. Gibbs wrote:
>> 
>> Actually, in reviewing your message more fully, the problem is that
>> the timeout for the rewind operation is too short for your configuration.
>> The timeout should go away if you bump up the timeout in the st driver
>> so that your tape drive can rewind in peace.
> 
> I guess there is something seriously wrong in the driver then: my SCSI
> cdrom  writers have the same problem. Result: lots of bad CDs.
> 
> Jos

I would have to see the messages to say.

--
Justin

