Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUEWUvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUEWUvc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUEWUvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 16:51:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7137 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262045AbUEWUva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 16:51:30 -0400
Message-ID: <40B10EC1.3030602@pobox.com>
Date: Sun, 23 May 2004 16:51:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
References: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com> <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 23 May 2004, Phy Prabab wrote:
> 
>>I have been researching the 4g patches for kernels. 
>>Seems there was a rift between people over this.  Is
>>there any plan to resume publishing 4g patches for
>>developing kernels?
> 
> 
> Quite frankly, a number of us are hoping that we can make them
> unnecessary. The cost of the 4g/4g split is absolutely _huge_ on some
> things, including basic stuff like kernel compiles.


Sorta like I'm hoping that cheap and prevalent 64-bit CPUs make PAE36 
and PAE40 on ia32 largely unnecessary.  Addressing more memory than 32 
bits of memory on a 32-bit CPU always seemed like a hack to me, and a 
source of bugs and lost performance...

	Jeff


