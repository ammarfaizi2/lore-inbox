Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFYTXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFYTXt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 15:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFYTXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 15:23:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15037 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261190AbVFYTXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 15:23:46 -0400
Message-ID: <42BDAF3D.6060809@namesys.com>
Date: Sat, 25 Jun 2005 12:23:41 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Mahoney <jeffm@suse.de>, penberg@gmail.com, ak@suse.de,
       flx@namesys.com, zam@namesys.com, vs@thebsh.namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>	 <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>	 <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>	 <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de>	 <20050623114318.5ae13514.akpm@osdl.org>  <20050623193247.GC6814@suse.de> <1119717967.9392.2.camel@localhost>
In-Reply-To: <1119717967.9392.2.camel@localhost>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>
>
>On Thu, 2005-06-23 at 21:32 +0200, Jens Axboe wrote:
>  
>
>>That said, I don't like the reiser name-number style. If you must do
>>something like this, mark responsibility by using a named identifier
>>covering the layer in question instead.
>>
>>        assert("trace_hash-89", is_hashed(foo) != 0);
>>    
>>
Lots of people like corporate anonymity.  Some don't.  I don't.  I like
knowing who wrote what.  It helps me know who to pay how much.  It helps
me know who to forward the bug report to.   Losing your anonymity
exposes you, mostly for better since more communication is on balance a
good thing, but the fear is there for some.  I don't think we can agree
on this, it is an issue of the soul. 
