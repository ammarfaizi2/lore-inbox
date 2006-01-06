Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWAFME5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWAFME5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWAFME5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:04:57 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:5886 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S1751194AbWAFME4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:04:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=nifty.com;
  b=Vm7ga53Ti+OVW742XwzkbRj/z8jy5kgNwrQ0EjJE5VNIfTbPe/fGJS+N+LrODqdoWQqBNflNCGiV+T5IsmCy/Q==  ;
Message-ID: <3378320.1136549095236.komurojun-mbn@nifty.com>
Date: Fri, 6 Jan 2006 21:04:55 +0900 (JST)
From: Komuro <komurojun-mbn@nifty.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: [KERNEL 2.6.15]  All files have -rw-rw-rw- permission.
In-Reply-To: <20060105191736.1ac95e4b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: @nifty Webmail 2.0
References: <20060105191736.1ac95e4b.rdunlap@xenotime.net>
 <1986219.1136463311449.komurojun-mbn@nifty.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>We (lkml) have been thru this before.
>Don't untar the tarball as root and this won't happen.
>

Thanks for your reply.

But, is there any reason to set -----w--w- bit
by default?

> tar tvjf linux-2.6.15.tar.bz2
>
>?rw------- git/git          52 1970-01-01 09:00:00 pax_global_header >unknown
 file type `g'
>drwxr-xr-x git/git           0 2006-01-03 12:21:10 linux-2.6.15/
>-rw-rw-rw- git/git         391 2006-01-03 12:21:10 linux-2.6.15/.gitignore
>-rw-rw-rw- git/git       18693 2006-01-03 12:21:10 linux-2.6.15/COPYING
>-rw-rw-rw- git/git       89582 2006-01-03 12:21:10 linux-2.6.15/CREDITS

Best Regards
Komuro

