Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUEYPco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUEYPco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUEYPco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:32:44 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:45154 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264924AbUEYPcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:32:22 -0400
In-Reply-To: <1085468812.2783.7.camel@laptop.fenrus.com>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085468812.2783.7.camel@laptop.fenrus.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B58A76BA-AE60-11D8-BD27-000A95CC3A8A@mesatop.com>
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [RFD] Explicitly documenting patch submission
Date: Tue, 25 May 2004 09:32:19 -0600
To: arjanv@redhat.com
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 25, 2004, at 1:06 AM, Arjan van de Ven wrote:

>
>
>> explanation part of the patch. That sign-off would be just a single 
>> line
>> at the end (possibly after _other_ peoples sign-offs), saying:
>>
>> 	Signed-off-by: Random J Developer <random@developer.org>
>
> well this obviously needs to include that you signed off on the DCO and
> not some other random piece of paper, and it probably should include 
> the
> DCO revision number you signed off on.
> Without the former the Signed-off-by: line is entirely empty afaics,
> without the later we're not future proof.
>
>

How about something like:

	DCO 1.0 Signed-off-by: Random J Developer <random@developer.org>

This new process being "an ounce of prevention is worth a pound
of cure" should retain the property of being lightweight and not
unduly burdensome.  This change seems to fall into that category.

	Steven 
   

