Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSGLJkb>; Fri, 12 Jul 2002 05:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSGLJka>; Fri, 12 Jul 2002 05:40:30 -0400
Received: from stingr.net ([212.193.32.15]:55962 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S315413AbSGLJka>;
	Fri, 12 Jul 2002 05:40:30 -0400
Date: Fri, 12 Jul 2002 13:43:16 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Paul P Komkoff Jr <i@stingr.net>
Subject: Re: Small fixes for -rc1 kernel
Message-ID: <20020712094316.GC2280@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Paul P Komkoff Jr <i@stingr.net>
References: <20020711195816.GA2280@stingr.net> <20020711210349.A11341@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020711210349.A11341@infradead.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Christoph Hellwig:
> > 2. Long lasting issue with wan/comx and proc_get_inode
> 
> comx is broken.  exporting proc_get_inode is still ABSOLUTELY wrong.

And who should fix it? I just don't understand the whole meaning of that
piece of code which uses proc_get_inode (yet)

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
