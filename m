Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271934AbRH2I5l>; Wed, 29 Aug 2001 04:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271935AbRH2I5b>; Wed, 29 Aug 2001 04:57:31 -0400
Received: from mons.uio.no ([129.240.130.14]:5817 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S271934AbRH2I5R>;
	Wed, 29 Aug 2001 04:57:17 -0400
To: "Tom Sightler" <ttsig@tuxyturvy.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: NFS Client and SMP
In-Reply-To: <Pine.LNX.4.05.10108281806180.20438-100000@lara.stud.fh-heilbronn.de>
	<shsk7zongjw.fsf@charged.uio.no>
	<001d01c13004$61965890$70751a0a@zeusinc.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Aug 2001 10:57:28 +0200
In-Reply-To: "Tom Sightler"'s message of "Tue, 28 Aug 2001 16:59:48 -0400"
Message-ID: <shsae0jtf9j.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Tom Sightler <ttsig@tuxyturvy.com> writes:

     > Is this problem specific to the 2.4 series or is the 2.2 NFS
     > implementation suspect to this as well.  I am curious because
     > we have a good number of SMP servers running SuSE's 2.2.19
     > kernel connected to a NetApp filer via GigE with jumbo frames
     > and have not had any problems during development.  However, we
     > are about 1 month from going production and load will increase
     > tremendously then (even though we've attempted to stress the
     > system in development, real production always introduces new
     > loads).

I don't have acces to a test setup for Gigabit, so I have to rely on
other people's reports. I can only remember hearing of problems in
2.4.x, however you might want to check the archives on the NFS
discussion list on Sourceforge.

Cheers,
  Trond
