Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUIBTl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUIBTl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIBTl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:41:59 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:64898 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268438AbUIBTlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:41:52 -0400
Date: Thu, 2 Sep 2004 21:41:44 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1535878866.20040902214144@tnonline.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Lee Revell <rlrevell@joe-job.com>, Jamie Lokier <jamie@shareable.org>,
       Pavel Machek <pavel@suse.cz>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
References: Message from Lee Revell <rlrevell@joe-job.com>    of "Wed, 01 Sep
 2004 18:51:12 -0400." <1094079071.1343.25.camel@krustophenia.net>
 <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Lee Revell <rlrevell@joe-job.com> said:

> [...]

>> FWIW, this is how Windows does it now.  As of XP, 'Find files' has an
>> option, enabled by default, to look inside archives.  If you tell it to
>> look for a driver in a given directory it will also look inside .cab
>> and .zip files.  It's extremely useful, I would imagine someone who uses
>> XP a lot will come to expect this feature.

> It is trivial to implement this by looking inside the files. I.e., the way
> mc has done this for ages.

  Difference is that you can't do "locate" or "find" or "Search".. You
  would have to open the files in an archive-supporting application
  such as mc.

