Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbTEFRWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTEFRWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:22:12 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:34565 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264000AbTEFRWJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:22:09 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: trond.myklebust@fys.uio.no
Subject: Re: [NFS] processes stuck in D state
Date: Tue, 6 May 2003 19:32:29 +0200
User-Agent: KMail/1.5.1
References: <200305061652.13280.fsdeveloper@yahoo.de> <200305061830.25417.fsdeveloper@yahoo.de> <16055.59608.512121.756564@charged.uio.no>
In-Reply-To: <16055.59608.512121.756564@charged.uio.no>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Zeev Fisher <Zeev.Fisher@il.marvell.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305061932.39828.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 06 May 2003 18:54, Trond Myklebust wrote:
> >>>>> " " == Michael Buesch <fsdeveloper@yahoo.de> writes:
>     >> kill -9 all the processes.  kill -9 rpciod.
>     >>
>      > kill -9 doesn't work for me to kill the app.
>
> I didn't say kill the app. I said signal it with -9, then signal
> rpciod.

Ah, I understand. :)

> Cheers,
>   Trond

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 19:31:20 up  3:22,  2 users,  load average: 1.23, 1.09, 1.04
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t/G3oxoigfggmSgRAq5BAJ0SezM+y1LFnwglArReHERXb2VJZQCeKKd0
Sx6RqCkOvm4FvgTCVyx2gCE=
=K8c7
-----END PGP SIGNATURE-----

