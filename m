Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUJYUKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUJYUKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUJYUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:09:54 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:48785 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261292AbUJYUEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:04:47 -0400
Message-ID: <417D5CEF.8080005@tmr.com>
Date: Mon, 25 Oct 2004 16:07:11 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: David Masover <ninja@slaphack.com>,
       =?ISO-8859-1?Q?Markus_T=F6rnqvi?= =?ISO-8859-1?Q?st?= 
	<mjt@nysv.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.9-mm1
References: <417B1574.4090406@slaphack.com><417B1574.4090406@slaphack.com> <417B3A34.2060306@namesys.com>
In-Reply-To: <417B3A34.2060306@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> David Masover wrote:
> 
>>
>> Some people don't care about speed but need space.  I'd leave them in on
>> general principle, even if no one wants them now.
> 
> 
> Software design is usually improved by identifying features that aren't 
> worth much, and removing them from the interface and burying them where 
> average users don't see them (or dumping them completely).  Interface 
> clutter has a cost.

We already have a section of odd things a user might want to do on a 
small, embedded, or special use. That might be a good place to put it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
