Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVJKBt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVJKBt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 21:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVJKBt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 21:49:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:50093 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751346AbVJKBt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 21:49:58 -0400
Message-ID: <434B1A2F.9090701@zytor.com>
Date: Mon, 10 Oct 2005 18:49:35 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>	 <20050831215757.GA10804@taniwha.stupidest.org>	 <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com>	 <431DFEC3.1070309@zytor.com> <2cd57c900510101848l5ecaa7e3p134f2e51950ab277@mail.gmail.com>
In-Reply-To: <2cd57c900510101848l5ecaa7e3p134f2e51950ab277@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> The kernel uses the setup.h COMMAND_LINE_SIZE for both assembly and C
> code. COMMAND_LINE_SIZE in param.h is only for bootloader IMHO.

Shouldn't really be there at all, then.

	-hpa
