Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWHIWIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWHIWIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWHIWIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:08:49 -0400
Received: from mail.visionpro.com ([63.91.95.13]:23434 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751398AbWHIWIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:08:48 -0400
User-Agent: Microsoft-Entourage/11.2.4.060510
Date: Wed, 09 Aug 2006 15:08:48 -0700
Subject: Re: Upgrading kernel across multiple machines
From: Brian McGrew <brian@visionpro.com>
To: Sam Ravnborg <sam@ravnborg.org>
CC: <linux-kernel@vger.kernel.org>
Message-ID: <C0FFAB00.89A2%brian@visionpro.com>
Thread-Topic: Upgrading kernel across multiple machines
Thread-Index: Aca8AGNhoatIfCfzEdu24AAKlbl8Ig==
In-Reply-To: <20060809220309.GA14665@mars.ravnborg.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would appear that way; but I assure you, the modules are in
/lib/modules/2.6.16.16/

:b!


On 8/9/06 3:03 PM, "Sam Ravnborg" <sam@ravnborg.org> wrote:

> On Wed, Aug 09, 2006 at 02:52:41PM -0700, Brian McGrew wrote:
>> Hello,
>> 
>> I'm using a Dell PE1800 and I've built a new 2.6.16.16 kernel on the machine
>> that works fine.  However, if I tar up /lib/modules/2.6.16.16 and /boot and
>> move it onto another Dell PE1800 running the exact same software (FC3/Stock
>> install) the new kernel doesn't boot.
>> 
>> On machine #1 life is good but moving it to machine #2, I get
>> 
>> /lib/ata_piix.ko: -l unknown symbol in module.
> Looks like your kernel modules has ended up in /lib somehow.
> Cannot see why atm.
> 
> Sam


:b!

-- 
Brian McGrew    { brian@visionpro.com || brian@doubledimenison.com }

> For economy reasons the light at the end of the tunnel has been turned off!

