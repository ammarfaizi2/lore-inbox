Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263628AbUDUS7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUDUS7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUDUS5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:57:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6895 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263620AbUDUS44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:56:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: James Simmons <jsimmons@infradead.org>, Jean Delvare <khali@linux-fr.org>
Subject: Re: Permissions on include/video/neomagic.h
Date: Wed, 21 Apr 2004 20:56:24 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0404211945240.9207-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0404211945240.9207-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404212056.24315.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 of April 2004 20:45, James Simmons wrote:
> > > > In linux-2.6.5.tar, include/video/neomagic.h has permissions 0640.
> > > > It obviously should be 0644.
> > >
> > > I'm preparing new neofb patch for Andrew Morton. They will fix this.
> >
> > Just curious... How can a patch change file permissions?
>
> If it is a BK patch I assume that would fix it.

http://linus.bkbits.net:8080/linux-2.5/cset@4082d4a3XJbVYeEqSdkkuhnyiEJ4Ww?nav=index.html|ChangeSet@-3d

Fix permission problem on include/video/neomagic.h
Change mode to -rw-r--r--

Just FYI ;)

