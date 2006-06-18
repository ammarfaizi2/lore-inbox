Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWFRLHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFRLHe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWFRLHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:07:34 -0400
Received: from mail-ale01.alestra.net.mx ([207.248.224.149]:34267 "EHLO
	mail-ale01.alestra.net.mx") by vger.kernel.org with ESMTP
	id S1751136AbWFRLHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:07:33 -0400
Message-ID: <449533BC.9010404@att.net.mx>
Date: Sun, 18 Jun 2006 06:06:36 -0500
From: Hugo Vanwoerkom <rociobarroso@att.net.mx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: ck@vds.kolivas.org, linux list <linux-kernel@vger.kernel.org>
Subject: Re: sound skips on 2.6.16.17
References: <4487F942.3030601@att.net.mx> <200606161115.53716.ocilent1@gmail.com> <4493D24D.2010902@att.net.mx> <200606172129.56986.kernel@kolivas.org> <20060618024130.GA32399@tuatara.stupidest.org>
In-Reply-To: <20060618024130.GA32399@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sat, Jun 17, 2006 at 09:29:56PM +1000, Con Kolivas wrote:
>
>   
>>>> 1)  PCI-VIA-quirk-fixup-additional-PCI-IDs.patch
>>>>         
>
> that shouldn't break things, if it does I *really* want to know
>
>   
>>>> 2)
>>>>         
>> PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch
>>     
>
> nor should that, so again i would like to know if this is the one that
> makes a difference
>
>   
>>> Works like a charm. End of the sound skips.
>>>       
>
> what cpu/mainboard/etc
>
>   
CPU: athlon thoroughbred xp 2700+
mobo: EP=8VTAI
Chipset: VIA AGPset: VIA KT880 + VT8237
Memory: 2x512MB DDR
BIOS: Award BIOS dated 11/24/2004






