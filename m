Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUAPGjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 01:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUAPGjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 01:39:17 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:15750 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP id S265287AbUAPGjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 01:39:16 -0500
Message-ID: <40078710.6070107@online.no>
Date: Fri, 16 Jan 2004 07:39:12 +0100
From: Andreas Tolfsen <ato@online.no>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: True story: "gconfig" removed root folder...
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <20040115212304.GA25296@rlievin.dyndns.org> <Pine.LNX.4.58.0401152245030.27223@serv> <40070D64.6090307@online.no> <Pine.LNX.4.58.0401152354160.27223@serv>
In-Reply-To: <Pine.LNX.4.58.0401152354160.27223@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

> On Thu, 15 Jan 2004, Andreas Tolfsen wrote:
> 
> 
>>>What do you mean with "destroyed"? All I can reproduce here is that it's
>>>simply moved away, but it's still there!
>>
>>Is it supposed to be moved away?  I'm just being curious...
> 
> 
> Yes, this usually produces ".config.old", but there is nowhere a "rm -Rf"
> as the initial mail suggests.
> 

I see, thank you!  That makes more sense!



