Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUIJXzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUIJXzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUIJXzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:55:46 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:60689 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268036AbUIJXzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:55:10 -0400
Message-ID: <41424015.1020804@techsource.com>
Date: Fri, 10 Sep 2004 20:00:21 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Hans Reiser <reiser@namesys.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Jamie Lokier <jamie@shareable.org>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409101815.i8AIFc5i005300@localhost.localdomain>
In-Reply-To: <200409101815.i8AIFc5i005300@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Horst von Brand wrote:
> Hans Reiser <reiser@namesys.com> said:
> 
>>Timothy Miller wrote:
> 
> 
> [...]
> 
> 
>>>You know, if tools all need to be rewritten anyway to deal with the 
>>>file metadata "directory", then why not change the symbol that 
>>>delimits the metadata key?
> 
> 
>>because it is useful that it is only a style convention.  Changing the 
>>symbol makes it mandatory to distinguish metafiles from files.
> 
> 
> If they are really different than directories, it should be clear what is
> what, IMVHO. If they aren't different, they have no place here. Trying to
> break hoary Unix tradition (files and directories are separate) while
> pretending nothing has changed (see, a file can be handled just like a
> directory) just doesn't cut it.


I think that sums up what I was trying to say better than what I said 
did.  :)

