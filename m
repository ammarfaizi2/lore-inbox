Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWHXWU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWHXWU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422762AbWHXWU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:20:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:48319 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422761AbWHXWU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:20:27 -0400
Message-ID: <44EE2622.9020601@zytor.com>
Date: Thu, 24 Aug 2006 15:20:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Oleg Verych <olecom@flower.upol.cz>
CC: linux-kernel@vger.kernel.org, pingved@gmail.com
Subject: Re: [PATCH] boot: small change of halt method
References: <20060824184447.GA3346@windows95> <44EDF923.4030607@zytor.com> <44EE2228.5020807@flower.upol.cz> <44EE192F.3030906@zytor.com> <44EE2EA0.4060905@flower.upol.cz>
In-Reply-To: <44EE2EA0.4060905@flower.upol.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
> 
> then maybe "panic=timeout" could be applied here ?
> 

It could, yes, with some work.

	-hpa
