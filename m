Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUDZPU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUDZPU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDZPU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:20:26 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:31886 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262625AbUDZPUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:20:19 -0400
Message-ID: <408D28F5.1020209@tmr.com>
Date: Mon, 26 Apr 2004 11:21:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Wichert Akkerman <wichert@wiggy.net>
CC: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
References: <4082819E.10106@free.fr> <20040420074650.GA3040@pclin040.win.tue.nl> <20040420143634.GA12132@bitwizard.nl> <20040425221528.GB3040@pclin040.win.tue.nl> <20040426083142.GA26429@wiggy.net>
In-Reply-To: <20040426083142.GA26429@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> Previously Andries Brouwer wrote:
> 
>>The answer is always the same: it exists and is called partx.
> 
> 
> Is partx ready for prime time yet? The util-linux sources do not compile
> or install it by default and the only comment in the HISTORY file is
> 'code to play with, not to use'.

So partx is intended to provide a reason for not discussing putting the 
functionality into the kernel, rather than actually being robust enough 
to use? If the author doesn't think it's ready for production use, why 
mention it?


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
