Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUJKT0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUJKT0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbUJKT0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:26:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:19933 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268766AbUJKT0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:26:09 -0400
Message-ID: <416ADC63.6010709@osdl.org>
Date: Mon, 11 Oct 2004 12:17:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, davej@redhat.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: __init dependencies
References: <20041010225717.GA27705@redhat.com>	<Pine.GSO.4.61.0410111333260.19312@waterleaf.sonytel.be> <20041011121225.2f829507.akpm@osdl.org>
In-Reply-To: <20041011121225.2f829507.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>>I guess it's about time for a tool to autodetect __init dependencies?
> 
> 
> `make buildcheck' does this.  Looks like nobody is using it.

I have asked that one of the forever-building machines here (OSDL)
do that.
I'll get back to that request....

-- 
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
