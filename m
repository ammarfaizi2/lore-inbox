Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSJWM6P>; Wed, 23 Oct 2002 08:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264964AbSJWM6P>; Wed, 23 Oct 2002 08:58:15 -0400
Received: from rth.ninka.net ([216.101.162.244]:10134 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S264963AbSJWM6O>;
	Wed, 23 Oct 2002 08:58:14 -0400
Subject: Re: [miniPATCH] 2.5.44 fix compilation errors in the AFS fs
From: "David S. Miller" <davem@rth.ninka.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Marek <linux@hazard.jcu.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035368896.3968.31.camel@irongate.swansea.linux.org.uk>
References: <20021023095601.GB12175@hazard.jcu.cz> 
	<1035368896.3968.31.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 06:16:10 -0700
Message-Id: <1035378970.5950.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 03:28, Alan Cox wrote:
> On Wed, 2002-10-23 at 10:56, Jan Marek wrote:
> > The first of them fixed union afs_dirent_t and using this union in the
> > fs/afs/dir.c.
> > 
> 
> What compiler are you using, this is building fine with the gcc's I
> have. Is it 2.95 ?

David Howells has a full set of patches to clean up the
2.95 issues in AFS, they just didn't get integrated before
Linus took off.

