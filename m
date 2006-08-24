Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWHXVZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWHXVZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWHXVZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:25:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49619 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030471AbWHXVZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:25:16 -0400
Message-ID: <44EE192F.3030906@zytor.com>
Date: Thu, 24 Aug 2006 14:25:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Oleg Verych <olecom@flower.upol.cz>
CC: linux-kernel@vger.kernel.org, pingved@gmail.com
Subject: Re: [PATCH] boot: small change of halt method
References: <20060824184447.GA3346@windows95> <44EDF923.4030607@zytor.com> <44EE2228.5020807@flower.upol.cz>
In-Reply-To: <44EE2228.5020807@flower.upol.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
>>
> Why not to have a reboot here?
> Testing and getting such errors on my laptop, it needs a power cycle.
> 

It makes it harder to debug, mostly.

	-hpa
