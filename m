Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVLMVuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVLMVuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVLMVuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:50:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:38868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030247AbVLMVuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:50:18 -0500
Date: Tue, 13 Dec 2005 13:48:28 -0800
From: Greg KH <greg@kroah.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Daniel Drake <dsd@gentoo.org>, Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] RE: [patch 10/26] ACPI: Prefer _CST over FADT for C-state capabilities
Message-ID: <20051213214828.GA16412@kroah.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300567E76B@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300567E76B@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 01:56:26PM -0500, Brown, Len wrote:
> yes, the 3rd patch should go with the first two.
> I asked Linus to pull the 3rd patch upstream
> http://lkml.org/lkml/2005/12/6/32
> but this was just as he cut -rc5 and headed out for a week.
> 
> Linus,
> Can you pull that patch upstream before cutting 2.6.15?
> 
> Thanks Daniel for the follow-up,

Can someone send the patch to stable@ when it goes in so I can include
it in the next round?  I've moved the other two acpi patches for the
next release, pending this patch.

thanks,

greg k-h
