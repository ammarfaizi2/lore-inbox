Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSFDQss>; Tue, 4 Jun 2002 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSFDQsr>; Tue, 4 Jun 2002 12:48:47 -0400
Received: from mons.uio.no ([129.240.130.14]:54676 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S315207AbSFDQsp>;
	Tue, 4 Jun 2002 12:48:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Matthias Welk <welk@fokus.gmd.de>
Subject: Re: nfs slowdown since 2.5.4
Date: Tue, 4 Jun 2002 18:48:38 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206041253.44446.welk@fokus.gmd.de> <shsg0032pxw.fsf@charged.uio.no> <200206041756.55696.welk@fokus.gmd.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206041848.38954.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 17:56, Matthias Welk wrote:

> To get more info about this problem I compared the compile time and the nfs
> traffic between 2.4.18-4 and 2.5.20 on a RedHat 7.3 system.
> The sources (mosfet-liquid0.9.5.tar.gz - KDE style) were located on the
> local disc and the libraries were linked over nfs.
> The results attached to this mail show the big difference !



Details of your setup please... What mount options are you using, which NFS 
server implementation, filesystem on the server, networking cards,....

Cheers,
  Trond
