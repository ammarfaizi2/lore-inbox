Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVHLKtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVHLKtn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVHLKtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:49:42 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:20407 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750967AbVHLKtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:49:42 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 12 Aug 2005 12:49:28 +0200
References: <4pzyn-10f-33@gated-at.bofh.it> <4AubX-4w6-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E3X6P-0000cN-BB@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Subject: Re: Problem with usb-storage and /dev/sd?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> DervishD <lkml@dervishd.net> wrote:
>>  * Pete Zaitcev <zaitcev@redhat.com> dixit:
>> > On Wed, 10 Aug 2005 21:22:43 +0200, DervishD <lkml@dervishd.net> wrote:

>> > >     I'm not using hotplug currently so... how can I make the USB
>> > > subsystem to assign always the same /dev/sd? entry to my USB Mass
>> > > storage devices? [...]
>> > You cannot. Just mount by label or something...
> 
>>     Mounting by label won't work, the problem is the /dev entry,
>> which changes every time.
> 
> That's why you should mount by label...

Which label will a random USB stick have?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
