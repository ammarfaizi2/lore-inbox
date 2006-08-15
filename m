Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752081AbWHODEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbWHODEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWHODEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:04:53 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:30737 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S1752081AbWHODEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:04:52 -0400
Message-ID: <44E139CD.3080103@xs4all.nl>
Date: Tue, 15 Aug 2006 05:04:45 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Miller <davem@davemloft.net>, folkert@vanheusden.com
Subject: Re: And another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
References: <44E096B4.9090207@xs4all.nl> <20060814.130814.126764626.davem@davemloft.net>
In-Reply-To: <20060814.130814.126764626.davem@davemloft.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Udo van den Heuvel <udovdh@xs4all.nl>
> Date: Mon, 14 Aug 2006 17:28:52 +0200
> 
>> Since 2.6.17.x my kernel Oopses every few days. Bewlo is the log.
> 
> Contact whoever you got this "pptp_gre.c" source file from.
> It's not in the vanilla kernel, therefore we can't help you
> debug the problem.

pptpd is needed for my adsl connection.
pppd runs over it.
it is not part of the kernel.
