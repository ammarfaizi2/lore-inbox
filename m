Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315725AbSEILls>; Thu, 9 May 2002 07:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315726AbSEILlr>; Thu, 9 May 2002 07:41:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54450 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315725AbSEILlq>;
	Thu, 9 May 2002 07:41:46 -0400
Date: Thu, 09 May 2002 04:29:38 -0700 (PDT)
Message-Id: <20020509.042938.78984470.davem@redhat.com>
To: indigoid@higherplane.net
Cc: dank@kegel.com, khttpd-users@alt.org, linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020509114009.GD3855@higherplane.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: john slee <indigoid@higherplane.net>
   Date: Thu, 9 May 2002 21:40:09 +1000
   
   tux is more an application than an interface or mechanism.  applications
   historically haven't been distributed as part of the main kernel tree.

Arguable nfsd is an application.

Providing a direct in-kernel link between the page cache and providing
content (be it HTTP, FTP, NFS files, whatever) over sockets is a very
powerful concept.
