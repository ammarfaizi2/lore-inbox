Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVJYURO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVJYURO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVJYURO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:17:14 -0400
Received: from orb.pobox.com ([207.8.226.5]:64157 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932337AbVJYURN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:17:13 -0400
Message-ID: <435E92C7.8080506@pobox.com>
Date: Tue, 25 Oct 2005 16:17:11 -0400
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org> <435E8CFE.7060006@pobox.com> <Pine.LNX.4.64.0510251301540.10477@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510251301540.10477@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 25 Oct 2005, Mark Lord wrote: 
>>Are these lines of any use?
...
>>PCI quirk: region 1000-103f claimed by PIIX4 ACPI
>>PCI quirk: region 1040-105f claimed by PIIX4 SMB
>>PIIX4 devres C PIO at 15e8-15ef
>>PIIX4 devres I PIO at 03f0-03f7
>>PIIX4 devres J PIO at 002e-002f
> 
> You've got three of the "new" devres resources, and judging by the values, 
> I'd guess you have an IBM ThinkPad 600 series machine. No?

IBM Thinkpad A21p  850MHz P3.

Cheers!
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

