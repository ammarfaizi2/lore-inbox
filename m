Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbULJLGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbULJLGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 06:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULJLGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 06:06:50 -0500
Received: from viking.sophos.com ([194.203.134.132]:53261 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261178AbULJLGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 06:06:46 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 10/12/2004 11:06:38,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 10/12/2004 11:06:38,
	Serialize complete at 10/12/2004 11:06:38,
	S/MIME Sign failed at 10/12/2004 11:06:38: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 10/12/2004 11:06:42,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 10/12/2004 11:06:42,
	Serialize complete at 10/12/2004 11:06:42,
	S/MIME Sign failed at 10/12/2004 11:06:42: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 10/12/2004 11:06:45,
	Serialize complete at 10/12/2004 11:06:45
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, urban@teststation.com
Subject: Re: [BUG ?] smbfs open always succeeds
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF30DAAE12.E64B9793-ON80256F66.003C453F-80256F66.003D0A18@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Fri, 10 Dec 2004 11:06:42 +0000
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It seems Andrew applied this to the -mm tree.
>
>smb_file_open-retval-fix.patch

Hm, I guess I should have spotted that but unfortunately I don't have 
enough time to keep up with mm lately. :I

Marcelo, are you planning to put it in 2.4 ?


