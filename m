Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292263AbSBBKZy>; Sat, 2 Feb 2002 05:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292264AbSBBKZo>; Sat, 2 Feb 2002 05:25:44 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:63238 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S292263AbSBBKZd>; Sat, 2 Feb 2002 05:25:33 -0500
Message-ID: <3C5BBE96.1080408@namesys.com>
Date: Sat, 02 Feb 2002 13:25:26 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Steve Lord <lord@sgi.com>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Chris Mason <mason@suse.com>, green@thebsh.namesys.com
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Fri, Feb 01, 2002 at 03:05:38PM -0600, Steve Lord wrote:
>
>    > ext2 is the only filesystem which has O_DIRECT support.
>
>    And XFS ;-)
>
>I sent reiserfs O_DIRECT support patches to someone a while ago.  I
>can look to ressurect these (assuming I can find them!)
>
>Chris Mason is always going to be a better source for these anyhow, he
>certainly understands any complex nuances there may be.  Chris, do you
>have any cycles to comment on this please?
>
>
>
>
>  --cw
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
You might try sending them to me if you want them to be reviewed and 
hopefully go in.

Cc green@namesys.com if you do, because I will be away until the 24th.

Hans


