Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276875AbRJCSAy>; Wed, 3 Oct 2001 14:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276874AbRJCSAo>; Wed, 3 Oct 2001 14:00:44 -0400
Received: from quechua.inka.de ([212.227.14.2]:15932 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S276872AbRJCSAf>;
	Wed, 3 Oct 2001 14:00:35 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
In-Reply-To: <706340000.1002116485@gullevek.piwi.intern>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15oqKN-00058k-00@calista.inka.de>
Date: Wed, 03 Oct 2001 20:01:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <706340000.1002116485@gullevek.piwi.intern> you wrote:
> but to the point of that thread. we had reiser FS on a production server
> (Fileserver for NFS, Samba & Appletalk) and we nothing but troubles. It was
> an 2.2.16 kernel and i dunno witch reiserfs we used. But from this point
> forward I dun think I will use it again soon on a production server.

Do you had NFS Problems or do you had filesystem problems?

Because NFS interaction with Journaled Filesystems is/was an issue with
those recent kernels, as far as i understand.

Greetings
Bernd
