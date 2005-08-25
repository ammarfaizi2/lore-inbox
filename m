Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVHYO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVHYO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVHYO7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:59:16 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:55201 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S1751091AbVHYO7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:59:15 -0400
Date: Thu, 25 Aug 2005 20:24:19 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: starting function of keyboard.c in FC2.
In-Reply-To: <1124966754.3222.16.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.60.0508252021450.7169@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0508251606170.16200@lantana.cs.iitm.ernet.in>
 <1124966754.3222.16.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Aug 2005, Arjan van de Ven wrote:

> On Thu, 2005-08-25 at 16:10 +0530, P.Manohar wrote:
>>
>>     In RH9 the starting function of keyboard.c is handle_scancode,
>> this is
>> the function to which the scancode is given by the keyboard interrupt
>> handler, its fine, but in FC2 , this handle_scancode is not there,
>> it's
>> functionality is spitted and placed in several functions. What is the
>> starting function of keyboard.c in FC2?
>> if anybody knows please suggest on it.
>
> you forgot to mention what you need it for...
>
     I mentioned it. I want to know the starting function of keyboard.c in 
FC2, to which the keyboard interrupt handler gives the scancodes.
