Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUA3VW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbUA3VW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:22:58 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:5248 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S264163AbUA3VW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:22:56 -0500
Message-ID: <401ACB1E.9070304@lbl.gov>
Date: Fri, 30 Jan 2004 13:22:38 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.2-rc2
References: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401251844440.32583@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It's being uploaded right now, and the BK trees should already
> be uptodate.
> 
> There's a x86-64 update and IRDA updates here, and a number of USB storage
> fixes. The rest is pretty small. Full changelog from -rc1 appended.
> 
> 		Linus
> 

Did someone change the Intel CPU detection code in this version?

It won't boot on my dual athlon MP system.

2.6.2-rc1 does boot.

thomas
