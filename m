Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271336AbRIJQKw>; Mon, 10 Sep 2001 12:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271347AbRIJQKn>; Mon, 10 Sep 2001 12:10:43 -0400
Received: from ns.fmi.fi ([193.166.211.11]:25165 "EHLO ns.fmi.fi")
	by vger.kernel.org with ESMTP id <S271336AbRIJQKe>;
	Mon, 10 Sep 2001 12:10:34 -0400
Message-Id: <200109101610.f8AGAnrY018273@leija.fmi.fi>
Subject: Re: COW fs (Re: Editing-in-place of a large file)
In-Reply-To: <3B9C9FF3.7E2770AB@iph.to>
To: Ihar Filipau <philips@iph.to>
Date: Mon, 10 Sep 2001 19:10:48 +0300 (EEST)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kari Hurtta <hurtta+linux.kernel@leija.mh.fmi.fi>
X-Mailer: ELM [version 2.4ME+ PL94b (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
X-Filter: leija.fmi.fi: 1 received headers rewritten with id 20010910/14989/01
X-Filter: leija.fmi.fi: ID 1081, 1 parts scanned for known viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Charset KOI8-R unsupported, converting... ]
> 
> 	Is there any FS that have dynamic allocation?
> 
> 	On one partition can reside a number of FSs and using only needed space? this
> would be really cute - HD behaves just like RAM.
> 
> 	Some FSs on partition just like number files on FS.
> 	In other words "File Systems' System".
> 
> 	google and altavista both show nothing...
> 
> PS Interesting like academic task. Hm. Will invistigate.

Are you thinking something similar than AdvFS of Tru 64 ?

( storage or partition is called as 'volume'
  and filesystems which share volume are called as 'filesets' )

-- 
          /"\                           |  Kari 
          \ /     ASCII Ribbon Campaign |    Hurtta
           X      Against HTML Mail     |
          / \                           |
