Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbSJWKFi>; Wed, 23 Oct 2002 06:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264037AbSJWKFi>; Wed, 23 Oct 2002 06:05:38 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18366 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263960AbSJWKFh>; Wed, 23 Oct 2002 06:05:37 -0400
Subject: Re: [miniPATCH] 2.5.44 fix compilation errors in the AFS fs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021023095601.GB12175@hazard.jcu.cz>
References: <20021023095601.GB12175@hazard.jcu.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 11:28:16 +0100
Message-Id: <1035368896.3968.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 10:56, Jan Marek wrote:
> Hallo lkml,
> 
> I'm sending 2 patches to fix compilation errors in the AFS fs.
> 
> The first of them fixed union afs_dirent_t and using this union in the
> fs/afs/dir.c.
> 

What compiler are you using, this is building fine with the gcc's I
have. Is it 2.95 ?

