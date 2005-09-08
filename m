Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVIHAZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVIHAZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVIHAZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:25:21 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:32980 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932465AbVIHAZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:25:21 -0400
From: Grant <d_o_d_o_@dodo.com.au>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org,
       Grant Coady <lkml@dodo.com.au>, video4linux-list@redhat.com
Subject: Re: Some warnings and stuff GCC 4
Date: Thu, 08 Sep 2005 10:25:00 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <js0vh1hhanpqkhub4ftaatem6107v8abn2@4ax.com>
References: <431F292D.3070705@comcast.net> <431F53B6.6000805@gmail.com>
In-Reply-To: <431F53B6.6000805@gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2005 22:55:18 +0200, Jiri Slaby <jirislaby@gmail.com> wrote:
>>
>>drivers/media/video/zr36120.c: At top level:
>>drivers/media/video/zr36120.c:1821: error: unknown field 'open'
>>specified in initializer
>>> Being discussed on the V4L list
>>	It seems that nobody are interested on maintaining it. No answer from
>>V4L list subscribers.
>>
>>	I think it may be removed.
>
>Please no, I'll get to it, I have one to play with.
>Grant.
>
></cite>
>So, Grant, are you doing something with that or could we schedule it for 
>wiping out?

I plan to, time frame is couple or more weeks at the moment, doing other 
things right now.  Also plan to look at aztech-radio soon too, seems 
nobody wants to fix a warning it throws :)

Thanks,
Grant.

