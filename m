Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269019AbUIAArp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269019AbUIAArp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUHaTlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:41:52 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:21965 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268873AbUHaTiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:38:22 -0400
Date: Tue, 31 Aug 2004 21:38:08 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <111617109.20040831213808@tnonline.net>
To: Tonnerre <tonnerre@thundrix.ch>
CC: V13 <v13@priest.com>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea of what reiser4 wants to do with metafiles and why
In-Reply-To: <20040831190814.GA15493@thundrix.ch>
References: <41323AD8.7040103@namesys.com> <200408312055.56335.v13@priest.com>
 <36793180.20040831201736@tnonline.net> <20040831190814.GA15493@thundrix.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Salut,

> On Tue, Aug 31, 2004 at 08:17:36PM +0200, Spam wrote:
>>   How  are  things  done on Windows platforms when there are files and
>>   directories  with the same name? In Unix that is imposible. How does
>>   it  work  for  environments  like  Cygwin  etc? What happen to tools
>>   that run in them?

> In  NTFS it's  illegal  IIRC.  At least  the  fs correction  utilities
> complain about a block being assigned to two files.

  I  meant  a  file  and a directory with the same name, not two files
  with the same name :) subtle but important difference.

  ie,  you can have a file named "foo" and a directory named "foo" and
  they won't collide.
  

> Same with HFS+.

> Sometimes  there seem to  be several  things with  the same  name. But
> that's because of hidden extensions (.lnk for example).

> I'm talking out of the book here, maybe the real-world implementations
> of Windows  are different. I can't  tell, I only used  Windows once to
> ssh into a screwed-up router.

> 				Tonnerre


