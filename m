Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVCXKCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVCXKCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVCXKCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:02:07 -0500
Received: from adsl-69-233-54-133.dsl.pltn13.pacbell.net ([69.233.54.133]:7437
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S262085AbVCXKCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:02:04 -0500
Message-ID: <4242905D.6000109@tupshin.com>
Date: Thu, 24 Mar 2005 02:03:09 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <4242865D.90800@qazi.f2s.com>	 <20050324093032.GA14022@havoc.gtf.org> <1111656852.6290.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1111656852.6290.47.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>* "hardware firewall" -- sounds silly.  Pretty sure Linux doesn't support
>>it in any case.
>>
>>    
>>
>
>probably just one of those things implemented in the binary drivers in
>software, just like the "hardware" IDE raid is most of the time (3ware
>being the positive exception there)
>
Incorrect. While the logic is is almost certainly implemented in the 
drivers, there is silicon acceleration of the functionality built into 
the Nforce4 chipset (unlike the nforce3), and requires almost no CPU 
time to do its job. Nvidia calls this chipset support ActiveArmor.

-Tupshin
