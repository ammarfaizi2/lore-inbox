Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUD3IEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUD3IEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUD3IEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:04:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13503 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265109AbUD3IEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:04:35 -0400
Message-ID: <40920881.6070300@pobox.com>
Date: Fri, 30 Apr 2004 04:04:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Sean Estabrooks <seanlkml@rogers.com>, koke@sindominio.net,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, riel@redhat.com,
       david@gibson.dropbear.id.au, torvalds@osdl.org, miller@techsource.com,
       paul@wagland.net
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <200404292347.17431.koke_lkml@amedias.org> <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com> <20040429195553.4fba0da7.seanlkml@rogers.com> <3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com> <20040430004344.663acf90.seanlkml@rogers.com> <6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:
> 
> 
> On Apr 30, 2004, at 12:43 AM, Sean Estabrooks wrote:
> 
>>
>> Dear Marc,
>>
>> Who decided that the goal was to become ubiquitous at any cost?  How
>> are you so sure that removing the incentive/reward for hardware vendors
>> to release open source drivers is best for Linux in the long run?
> 
> 
> There are major chipset vendors out there who have managed to become 
> market leaders while not providing any drivers for Linux.

I'm not so sure you should pluralize "vendors"  ;-)


> But other vendors are also still releasing new native linux drivers, 
> despite the availability of our solutions (Intel's project for Centrino 
> at ipw2100.sourceforge.net is a great example).
> 
> This essentially proves that we are not removing the incentive to do 
> proper native drivers,

That conclusion cannot be drawn from the pretense...

It's strictly a cost-based function for a business.  If a business can 
achieve Linux support for free, without paying driver and support 
engineers, they do so.

DriverLoader significantly lowers that cost, while not providing an open 
source solution at all.

	Jeff



