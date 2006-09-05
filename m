Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWIFL6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWIFL6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWIFL6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:58:15 -0400
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:50837 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1750729AbWIFL6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:58:14 -0400
Message-ID: <44FCE36D.4000708@gentoo.org>
Date: Mon, 04 Sep 2006 22:39:41 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Stian Jordet <liste@jordet.net>
CC: akpm@osdl.org, sergio@sergiomb.no-ip.org, jeff@garzik.org, greg@kroah.com,
       cw@f00f.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
References: <20060906020429.6ECE67B40A0@zog.reactivated.net> <44FE8EBA.4060104@jordet.net>
In-Reply-To: <44FE8EBA.4060104@jordet.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stian Jordet wrote:
> Daniel Drake wrote:
>> Stian Jordet: You're on CC due to a discussion linked to from above where
>> it appeared that you needed Bjorn's patch. Please test this patch against
>> unmodified 2.6.17 or 2.6.18-rc and let us know if there are any problems.
>>
> No more usb for me with this patch :P

Please send dmesg from both a working kernel and a patched kernel, and 
/proc/interrupts from both too.

Thanks,
Daniel
