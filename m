Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUIFCyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUIFCyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 22:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIFCyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:54:09 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:37203 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267404AbUIFCyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:54:05 -0400
Message-ID: <413BD14A.9050800@yahoo.com.au>
Date: Mon, 06 Sep 2004 12:54:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ppc64] Allow SD_NODES_PER_DOMAIN to be overridden
References: <20040902123713.GD26072@krispykreme> <20040904153316.GB7716@krispykreme> <413A1052.6020400@yahoo.com.au> <200409050824.47853.jbarnes@engr.sgi.com>
In-Reply-To: <200409050824.47853.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:

>
>Yep, if I add the arch define the domains are built correctly.  Though I'm 
>getting a warning:
>
>...
>ERROR groups don't span domain->span
>CPU31:  online
>...
>
>

Hmm, this might be a problem. I don't think it can have been different 
before
this patch though... Can you send the full output privately? Thanks.


>Here's the updated patch.
>
>Jesse (note, no 'i')
>
>

Sorry - I think it is one of those letter sequences that is hard-wired
in my brain :\

