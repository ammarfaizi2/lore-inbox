Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVBWVhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVBWVhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVBWVhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:37:08 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:14807 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261573AbVBWVgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:36:52 -0500
Message-ID: <421CF878.1080109@tmr.com>
Date: Wed, 23 Feb 2005 16:41:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
References: <421A2D8F.3050704@pobox.com><421A2D8F.3050704@pobox.com> <20050221194227.GH6722@wiggy.net>
In-Reply-To: <20050221194227.GH6722@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> Previously Jeff Garzik wrote:
> 
>>You should add this to your procmailrc :)
>>
>># Nuke duplicate messages
>>:0 Wh: msgid.lock
>>| $FORMAIL -D 32768 msgid.cache
> 
> 
> That has the nasty side-effect of spreading messages for a single
> discussion amongst many different mailboxes depending on which path
> happens to be the first to deliver an email to you.

It depends on how you process your mail, if you move to folders with 
determanent logic, checking various lists in order, then it always does 
the same thing. If you use the list header it could do what you suggest. 
I personally push a lot of the mailing lists to a news (usenet) server, 
since it allows a single copy of a message to be indexed in multiple 
groups, and some clients will skip what you have seen better than others.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
