Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUIBLiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUIBLiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUIBLiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:38:07 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:38793 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S268214AbUIBLiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:38:04 -0400
Message-ID: <1094125083.4137061b54913@imp1-q.free.fr>
Date: Thu,  2 Sep 2004 13:38:03 +0200
From: castet.matthieu@free.fr
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pnp and acpi_pnp
References: <566B962EB122634D86E6EE29E83DD808182C46FD@hdsmsx403.hd.intel.com> <1094005570.3943.55.camel@linux>
In-Reply-To: <1094005570.3943.55.camel@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 62.147.113.144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Len Brown <len.brown@intel.com>:

> Matthieu,
> PNPBIOS should be disabled when ACPI is enabled, and it is a bug that
> this is not automatic.
>
> yes, the "Linux PNP" layer is incomplete, and ACPI isn't yet plugged
> into that.
>
> cheers,
> -Len
>
>
>


Hi,
thanks for your reply.

What about the fact that acpi pnp don't make the difference between a normal
serial port and a ir port ?

I hope acpi will be plugged soon in Linux PNP layer.

regards,
Matthieu
