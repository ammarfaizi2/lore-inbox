Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279661AbRKAXK1>; Thu, 1 Nov 2001 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279846AbRKAXKR>; Thu, 1 Nov 2001 18:10:17 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:14088 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S279661AbRKAXKH>; Thu, 1 Nov 2001 18:10:07 -0500
Message-ID: <3BE1D632.E729C35B@namesys.com>
Date: Fri, 02 Nov 2001 02:09:38 +0300
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <Pine.LNX.4.30.0111011754580.2106-100000@mustard.heime.net> <20011101130721.D16554@lynx.no>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Nov 01, 2001  18:14 +0100, Roy Sigurd Karlsbakk wrote:
> > Novell NetWare has a feature I really like. It's a file compression
> > feature they've been having since version 4.0 (or 4.10) of the OS.
> 
> Yes, there is a patch for ext2 that does this as well.

We try to be aggressive about merging patches in at Namesys.  If you are
generous enough to write a patch for ReiserFS, we will either tell you it is not
good, or take it, in a timely manner.  Anyone this does not happen with should
complain to me and I will delve into who forgot it and motivate them.  

Hans
