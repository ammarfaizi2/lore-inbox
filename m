Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTEPFaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTEPFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:30:11 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:6907 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264124AbTEPFaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:30:09 -0400
Message-ID: <3EC47A57.30407@nortelnetworks.com>
Date: Fri, 16 May 2003 01:42:47 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: techstuff@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: The kernel is miscalculating my RAM...
References: <200305131415.37244.techstuff@gmx.net> <200305140650.h4E6oCu04880@Port.imtp.ilyichevsk.odessa.ua> <200305160003.25262.techstuff@gmx.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Kurktchiev wrote:
> ok here is what dmesg shows:
> 384MB LOWMEM available.
> 
> then further down:
> Memory: 385584k/393216k available
> 
> now how is the little 38.../39... possible? 

384 * 1024 * 1000 = 393216000






-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

