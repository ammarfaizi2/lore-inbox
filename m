Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281478AbRKPSwS>; Fri, 16 Nov 2001 13:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281480AbRKPSwI>; Fri, 16 Nov 2001 13:52:08 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:43517 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S281478AbRKPSwD>; Fri, 16 Nov 2001 13:52:03 -0500
Message-Id: <200111161851.fAGIpwE24877@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: jap3003+response@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: CacheFS for Linux?
Date: Fri, 16 Nov 2001 13:51:47 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011116123500.A12988@ksu.edu>
In-Reply-To: <20011116123500.A12988@ksu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't claim to be an expert on the subject, but you may want to look at 
the coda client/server.  Local caching and multiple origin servers are two 
of its major features.

Of course, this is entirely separate from NFS, so if an NFS server is your 
only option, it means nothing.

	-- Brian

On Friday 16 November 2001 01:35 pm, Joseph Pingenot wrote:
> Hello.
>
> Has any work been done on creating a sort of CacheFS for Linux
>   (local NFS caching)?  If so, where can I go to get more info
>   on getting it up and running?  Or is it already implemented
>   somewhere?
> Thanks!
