Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTIBA0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbTIBA0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:26:41 -0400
Received: from terminus.zytor.com ([63.209.29.3]:52621 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263387AbTIBA0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:26:40 -0400
Message-ID: <3F53E3AB.7070604@zytor.com>
Date: Mon, 01 Sep 2003 17:26:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mfedyk@matchmail.com, superchkn@sbcglobal.net, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: -mm patches on www.kernel.org ?
References: <Pine.LNX.4.51.0308071636100.31463@dns.toxicfilms.tv>	<20030901211108.GE31760@matchmail.com>	<3F53B937.10103@sbcglobal.net>	<20030901225339.GH31760@matchmail.com>	<3F53DEE1.5000709@zytor.com> <20030901171435.1ef05cc8.akpm@osdl.org>
In-Reply-To: <20030901171435.1ef05cc8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> Well I always have a full rollup there, such as
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm4/2.6.0-test4-mm4.gz
> 
> Is that what you mean?
> 
> (It would be good to add -aa patchsets too).
 >

I might be able to do this.  However, please understand, everyone, that 
having to write individual scripts for each kernel author is turning 
into a horrible pain in the ass.  I think the only sane way to do this 
is to come up with a standard directory layout for specific user patches.

	-hpa

