Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269020AbUHMH5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbUHMH5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269022AbUHMH5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:57:46 -0400
Received: from mail2.srv.poptel.org.uk ([213.55.4.14]:50446 "HELO
	mail2.srv.poptel.org.uk") by vger.kernel.org with SMTP
	id S269020AbUHMH5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:57:44 -0400
Message-ID: <411C73FE.9020107@phonecoop.coop>
Date: Fri, 13 Aug 2004 08:55:42 +0100
From: Alan Jenkins <sourcejedi@phonecoop.coop>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: chris@theclaytons.giointernet.co.uk
Subject: Re: CDMRW in 2.6
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk> <20040813071537.GE2321@suse.de>
In-Reply-To: <20040813071537.GE2321@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Mon, Aug 09 2004, Chris Clayton wrote:
>  
>
>>cdrom: hdc: mrw address space DMA selected
>>cdrom open: mrw_status 'mrw complete'
>>hdc: command error: status=0x51 { DriveReady SeekComplete Error }
>>hdc: command error: error=0x54
>>end_request: I/O error, dev hdc, sector 1048576
>>    
>>
>
>Command was aborted, probably the media isn't writable after all.  Can
>you try and force a full format with cdrwtool?
>
>  
>
I don't like to sound critical or "me too"-ish, but I have had the same 
problem with my LiteOn Combo SOHC-5232K. The error and status codeswere 
the same. I contacted Jens Axboe, but he wasn't able to help me and 
suggested it was a firmware problem. I'll try the suggestion. I hope 
this isn't a problem with a ll LiteOn drives.


