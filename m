Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269025AbTCAVFQ>; Sat, 1 Mar 2003 16:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269027AbTCAVFQ>; Sat, 1 Mar 2003 16:05:16 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:40129 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S269025AbTCAVFP>; Sat, 1 Mar 2003 16:05:15 -0500
Message-ID: <3E612561.1050002@kegel.com>
Date: Sat, 01 Mar 2003 13:25:53 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303012026410.31670-101000@korben.citd.de>
In-Reply-To: <Pine.LNX.4.44.0303012026410.31670-101000@korben.citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> This versions defaults to only correct words within a comment. ...
> // Comments are easy(tm). "Everything after // until line-end".
> 
> and /* ... */ are easy(tm) too because gcc doesn't support to nest them.

I'll be damned.  I'm impressed with how easy that was in perl.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

