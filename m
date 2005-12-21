Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVLUSwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVLUSwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVLUSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:52:20 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:33301 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751180AbVLUSwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:52:19 -0500
Message-ID: <43A9A460.6000300@gentoo.org>
Date: Wed, 21 Dec 2005 18:52:16 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: "Brown, Len" <len.brown@intel.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 10/26] ACPI: Prefer _CST over FADT for C-state capabilities
References: <F7DC2337C7631D4386A2DF6E8FB22B300567E76B@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300567E76B@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Brown, Len wrote:
> yes, the 3rd patch should go with the first two.
> I asked Linus to pull the 3rd patch upstream
> http://lkml.org/lkml/2005/12/6/32
> but this was just as he cut -rc5 and headed out for a week.
> 
> Linus,
> Can you pull that patch upstream before cutting 2.6.15?

This patch still isn't in your tree. Can you please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Thanks,
Daniel
