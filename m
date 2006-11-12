Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754939AbWKLDdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbWKLDdA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 22:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbWKLDdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 22:33:00 -0500
Received: from mail.suse.de ([195.135.220.2]:4244 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754938AbWKLDc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 22:32:59 -0500
From: Andi Kleen <ak@suse.de>
To: caglar@pardus.org.tr
Subject: Re: [Opps] Invalid opcode
Date: Sun, 12 Nov 2006 04:32:46 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611051740.47191.ak@suse.de> <200611120439.56199.caglar@pardus.org.tr>
In-Reply-To: <200611120439.56199.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611120432.47105.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 November 2006 03:39, S.Çağlar Onur wrote:
> 05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen şunları yazmıştı: 
> > And does it still happen in 2.6.19-rc4?
> 
> Sorry for delayed test result, i cannot reproduce this panic with 2.6.19-rc5

It's probably still there, just hopefully it won't be release critical
for .19 then.

At some point it has to be fixed properly by converting i386 to the 
new hotplug architecture i suppose.

-Andi

