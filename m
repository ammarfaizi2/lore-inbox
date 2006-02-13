Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWBMWLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWBMWLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWBMWLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:11:08 -0500
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:2707 "EHLO
	ds666.l4x.org") by vger.kernel.org with ESMTP id S1030206AbWBMWLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:11:07 -0500
Message-ID: <43F103F5.7010401@l4x.org>
Date: Mon, 13 Feb 2006 23:11:01 +0100
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051017 Thunderbird/1.0.7 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <43F04780.7020605@l4x.org> <Pine.LNX.4.64.0602130747300.3691@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602130747300.3691@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.2.134
X-SA-Exim-Mail-From: jdi@l4x.org
Subject: Re: Linux 2.6.16-rc3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on ds666.starfleet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 13 Feb 2006, Jan Dittmer wrote:
> 
>>This breaks compilation on 3 archs compared to -rc2:
>>
>>- mips: broke
>>- sparc: broke
>>- sparc64: broke
> 
> 
> Should be ok in -git now, pls verify.
> 

- mips: fixed
  Details: http://l4x.org/k/?d=10915

- sparc: fixed
  Details: http://l4x.org/k/?d=10932

- sparc64: fixed
  Details: http://l4x.org/k/?d=10933

Good work,

Jan
