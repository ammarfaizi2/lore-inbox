Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265322AbUEZGi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbUEZGi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 02:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbUEZGi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 02:38:26 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:52172 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S265322AbUEZGiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 02:38:25 -0400
Message-ID: <40B43B5F.8070208@nodivisions.com>
Date: Wed, 26 May 2004 02:38:23 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why swap at all?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a general question about ram/swap and relating to some of the issues in 
this thread:

	~500 megs cached yet 2.6.5 goes into swap hell

Consider this: I have a desktop system with 256MB ram, so I make a 256MB 
swap partition.  So I have 512MB "memory" and if some process wants more, 
too bad, there is no more.

Now I buy another 256MB of ram, so I have 512MB of real memory.  Why not 
just disable my swap completely now?  I won't have increased my memory's 
size at all, but won't I have increased its performance lots?

Or, to make it more appealing, say I initially had 512MB ram and now I have 
1GB.  Wouldn't I much rather not use swap at all anymore, in this case, on 
my desktop?

-Anthony
http://nodivisions.com/
