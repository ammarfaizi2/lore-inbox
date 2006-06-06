Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWFFODB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWFFODB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWFFODB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:03:01 -0400
Received: from rtr.ca ([64.26.128.89]:7383 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932170AbWFFODA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:03:00 -0400
Message-ID: <44858B0F.7020704@rtr.ca>
Date: Tue, 06 Jun 2006 10:02:55 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux UWB and Wireless USB project
References: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407> <20060605231233.GJ3469@elf.ucw.cz>
In-Reply-To: <20060605231233.GJ3469@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>
> Common cellphones are 2W, iirc; (so it would be ~1mW) but I was more
> interested in system power consumption. WIFI is too power intensive
> for a cellphone (mostly). Is this designed to go into cellphones?
> notebooks?

Most mobile phones in North America typically max out at 0.5W,
and spent much of the time operating in the uW - mW txpower range.

I've forgotten the specs for GSM in Europe.

Cheers
