Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVDIBLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDIBLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDIBLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:11:51 -0400
Received: from ds01.webmacher.de ([213.239.192.226]:63659 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261236AbVDIBKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:10:40 -0400
In-Reply-To: <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <4256BE7D.5040308@tiscali.de> <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1ebb1ef119c97acc5981e57f4d02bc99@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Chris Wedgwood <cw@f00f.org>, Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Kernel SCM saga..
Date: Sat, 9 Apr 2005 03:09:56 +0200
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-04-08, at 20:14, Linus Torvalds wrote:

>
>
> On Fri, 8 Apr 2005, Matthias-Christian Ott wrote:
>>
>> Ok, but if you want to search for information in such big text files 
>> it
>> slow, because you do linear search
>
> No I don't. I don't search for _anything_. I have my own
> content-addressable filesystem, and I guarantee you that it's faster 
> than
> mysql, because it depends on the kernel doing the right thing (which it
> does).

Linus.... Sorry but you mistake the frequently seen SQL db abuse as DATA
storage for what SQL databases are good at storing: well defined 
RELATIONS.
Sure a filesystem is for data. SQL is for relations.

