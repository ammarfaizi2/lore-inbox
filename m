Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUESPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUESPno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUESPkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:40:55 -0400
Received: from mail.tmr.com ([216.238.38.203]:12443 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S264251AbUESPiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:38:23 -0400
Message-ID: <40AB8147.5080404@tmr.com>
Date: Wed, 19 May 2004 11:46:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] eepro100 vs e100?
References: <200405190858.44632.lkml@kcore.org>
In-Reply-To: <200405190858.44632.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck wrote:

> I'm currently in the process of cleaning up my 2.6 kernel configuration on my 
> trusty SMP HP Netserver LC3, which comes shipped with 2 identical intel Pro 
> Ethernet 100 mbit cards:

While initially there did seem to be lockups with multiple e100 devices, 
I haven't seen that in some versions. I have several servers which run 
the NICs at 70-80 Mbit all the time and see no issues with the e100 at 
this time.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
