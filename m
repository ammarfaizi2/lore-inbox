Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUCRKfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 05:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbUCRKfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 05:35:21 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:45768 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S262501AbUCRKfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 05:35:17 -0500
Message-ID: <40597BF2.80807@free.fr>
Date: Thu, 18 Mar 2004 11:37:38 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
References: <40596FC5.3080703@free.fr> <20040318100222.GE22234@suse.de> <20040318100606.GG22234@suse.de>
In-Reply-To: <20040318100606.GG22234@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>Ah damn, requeue through blk_insert_request... Let me think about this
>>a bit, I'll post a fix for you.
> 
> 
> Does this work for you?

At least it does avoid the message at boot time :-) Thanks for your 
quick reply. Who still thinks OSS is not supported?

Thanks a lot and have a nice day,

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



