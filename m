Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSJDNLm>; Fri, 4 Oct 2002 09:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJDNLm>; Fri, 4 Oct 2002 09:11:42 -0400
Received: from videira.terra.com.br ([200.176.3.5]:44930 "EHLO
	videira.terra.com.br") by vger.kernel.org with ESMTP
	id <S261693AbSJDNLl>; Fri, 4 Oct 2002 09:11:41 -0400
Date: Fri, 4 Oct 2002 10:17:12 -0300
From: Christian Reis <kiko@async.com.br>
To: Juergen Hasch <Hasch@t-online.de>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] 2.4.19+trond and diskless locking problems
Message-ID: <20021004101712.A333@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <200210040907.47257.hasch@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210040907.47257.hasch@t-online.de>; from Hasch@t-online.de on Fri, Oct 04, 2002 at 09:07:47AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 09:07:47AM +0200, Juergen Hasch wrote:
> I got the same messages when mounting an AIX client to a Linux server after 
> upgrading to 2.4.19 Kernel.
> After installing the latest NFS utils, the problem went away.

Does this mean nfs-utils-1.0.1 vs 1.0, or were you using a much older
version?

> So I guess Trond is right, try looking at the userspace utilities.

I will, thanks.

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
