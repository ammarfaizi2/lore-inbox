Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSJDPza>; Fri, 4 Oct 2002 11:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262155AbSJDPz0>; Fri, 4 Oct 2002 11:55:26 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:31405 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262148AbSJDPzZ> convert rfc822-to-8bit; Fri, 4 Oct 2002 11:55:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hasch@t-online.de (Juergen Hasch)
To: Christian Reis <kiko@async.com.br>
Subject: Re: [NFS] 2.4.19+trond and diskless locking problems
Date: Fri, 4 Oct 2002 18:00:51 +0200
X-Mailer: KMail [version 1.4]
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20021003184418.K3869@blackjesus.async.com.br> <200210040907.47257.hasch@t-online.de> <20021004101712.A333@blackjesus.async.com.br>
In-Reply-To: <20021004101712.A333@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210041800.51540.hasch@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. Oktober 2002 15:17 schrieb Christian Reis:
> On Fri, Oct 04, 2002 at 09:07:47AM +0200, Juergen Hasch wrote:
> > I got the same messages when mounting an AIX client to a Linux server
> > after upgrading to 2.4.19 Kernel.
> > After installing the latest NFS utils, the problem went away.
>
> Does this mean nfs-utils-1.0.1 vs 1.0, or were you using a much older
> version?

Versions 0.3.3 and 1.0.1 are working fine for me, so it looks like
your problem is different.

...Juergen

