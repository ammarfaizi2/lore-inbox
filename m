Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269792AbUH0AEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269792AbUH0AEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269824AbUH0ABN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:01:13 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41418 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269700AbUHZXxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:53:51 -0400
Message-ID: <412E7806.9010409@namesys.com>
Date: Thu, 26 Aug 2004 16:53:42 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408260927100.26316-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408260927100.26316-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Thu, 26 Aug 2004, Hans Reiser wrote:
>
>  
>
>>I agree that your work is important without agreeing that MS client 
>>domination will last.;-)  It is indeed my desire to give you every 
>>single feature you need to emulate MS streams within files, but doing it 
>>using directories that are files.  I would like to support you in 
>>emulating windows faster than windows.
>>    
>>
>
>1) how do you back up and restore files with streams inside ?
>
>2) how do standard unix utilities handle them ?
>
>  
>
To repeat, I think it would be nice to implement a 
filename/pseudos/backup method for all the plugins.

Guys, we just have the beginnings in place.  One plugin method at a time 
it will all fall into place.

What we have now is useful now.  The more methods come into existence, 
the more compelling it becomes --- standard network economic theory 
applies here.

Hans
