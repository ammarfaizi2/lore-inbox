Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965332AbWHOKCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965332AbWHOKCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965344AbWHOKCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:02:10 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:57614 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP id S965332AbWHOKCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:02:09 -0400
Message-ID: <44E19B96.7020903@xs4all.nl>
Date: Tue, 15 Aug 2006 12:01:58 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Miller <davem@davemloft.net>, folkert@vanheusden.com
Subject: Re: And another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
References: <44E096B4.9090207@xs4all.nl>	<20060814.130814.126764626.davem@davemloft.net>	<44E139CD.3080103@xs4all.nl> <20060814.222504.61951856.davem@davemloft.net>
In-Reply-To: <20060814.222504.61951856.davem@davemloft.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Udo van den Heuvel <udovdh@xs4all.nl>
> 
>> pptpd is needed for my adsl connection.
>> pppd runs over it.
>> it is not part of the kernel.
> 
> Oh yes it does, the pptp source file was mentioned by the kernel OOPS
> message.  How did it get there if it's not part of the kernel? :)

It IS not part of the kernel. See the log. I left it there since it
shows some of the issues the Oops causes.
*Everytime* named is involved.
It eats entropy.
It upsets upsd and pptpd.
It happens since 2.6.17.*.

Kind regards,
Udo
