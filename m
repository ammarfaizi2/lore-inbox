Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263863AbRFIXhj>; Sat, 9 Jun 2001 19:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263916AbRFIXh3>; Sat, 9 Jun 2001 19:37:29 -0400
Received: from t2.redhat.com ([199.183.24.243]:57079 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263863AbRFIXhM>; Sat, 9 Jun 2001 19:37:12 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15138.44403.815959.756121@pizda.ninka.net> 
In-Reply-To: <15138.44403.815959.756121@pizda.ninka.net>  <15138.42357.146305.892652@pizda.ninka.net> <Pine.LNX.4.33.0106092356360.23184-100000@infradead.org> 
To: "David S. Miller" <davem@redhat.com>
Cc: Riley Williams <rhw@MemAlpha.CX>, Adrian Cox <adrian@humboldt.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable endianess problem in TLAN driver 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Jun 2001 00:36:08 +0100
Message-ID: <26927.992129768@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



davem@redhat.com said:
> Riley Williams writes:
>  > Even if that wasn't true, aren't the above all self-recursive
>  > definitions that would prevent anything calling them from compiling?

> Yes, it looks that way. 

cpp doesn't recurse. 

--
dwmw2


