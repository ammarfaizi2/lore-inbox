Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVBUUdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVBUUdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVBUUdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:33:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2695 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262089AbVBUUdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:33:32 -0500
Message-ID: <421A4574.1000604@pobox.com>
Date: Mon, 21 Feb 2005 15:32:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.11rc4: irq 5, nobody cared
References: <20050220155600.GD5049@vanheusden.com> <4218C692.9040106@tiscali.de> <20050220180550.GA18606@ime.usp.br> <200502211943.59887.bzolnier@elka.pw.edu.pl> <421A2D8F.3050704@pobox.com> <20050221194227.GH6722@wiggy.net>
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

These are _duplicate_ messages.  The To/CC doesn't vary in my 
experience.  Therefore, sorting on To/CC always guarantees my messages 
go into the correct folder.

Maybe you are thinking of reply-to-munged lists, which eliminate 
duplicates by eliminating custom To/CC lists.

	Jeff

