Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUHOInN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUHOInN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 04:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUHOInN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 04:43:13 -0400
Received: from as1-1-4.nvik.s.bonet.se ([194.236.255.141]:8832 "EHLO zappa.cx")
	by vger.kernel.org with ESMTP id S266548AbUHOInM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 04:43:12 -0400
Message-ID: <411F2216.50103@zappa.cx>
Date: Sun, 15 Aug 2004 10:43:02 +0200
From: Andreas Sundstrom <sunkan@zappa.cx>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.6.8 and ingress scheduling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-4.9) BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hello,
> 
> the last line (filter add) in the "wondershaper" script does sth. to the
> kernel, that lets it panic on receiving network packets.
> 
> now, if I could capture the trace, that was great... nothing is on disk,
> its also more than fits on the screen, and no scrollback exists.
> 
> please cc answers/questions,
> 
> regards,
> 
> peter
[...]

I can confirm that I have this problem too.
If anyone want me to try a patch just let me know.

/Andreas Sundstrom
