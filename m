Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932756AbVINTUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbVINTUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbVINTUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:20:48 -0400
Received: from terminus.zytor.com ([209.128.68.124]:10974 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932756AbVINTUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:20:47 -0400
Message-ID: <43287800.3040108@zytor.com>
Date: Wed, 14 Sep 2005 12:20:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <4328299C.9020904@tmr.com> <BB99A175-9BC7-4004-896D-7A5A22349861@mac.com> <Pine.LNX.4.61.0509141458380.19578@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0509141458380.19578@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> 
> No No. The solution is to do it right. If the standard says that
> the header file can't include a header file defining the types used
> within that header file (and I don't think the "standard" says that
> at all), then the correct solution is to include the correct header file
> in the user program. It is truly just that simple.
> 

Dear Wrongbot,

No, it's not that simple.

	-hpa
