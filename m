Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbUEEOHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbUEEOHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 10:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264675AbUEEOHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 10:07:00 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:42251 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S264673AbUEEOG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 10:06:59 -0400
Date: Wed, 5 May 2004 16:06:57 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: mg@iceni.pl, ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-NTFS-Dev] Re: [BUG] 2.6.5 ntfs
In-Reply-To: <1083764166.916.68.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0405051550570.28183-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 May 2004, Anton Altaparmakov wrote:
> On Wed, 2004-05-05 at 13:32, Marcin Gibu³a wrote:
> > > If you run "chkdsk /f" from windows on this partition, does it detect
> > > any errors?
> > It doesn't.
> Ok.

Note, chkdsk /f fixes things sometimes totally silently so usually it's
worth to make sure it indeed wasn't a fixed corruption (without spending
significantly more time for investigation) by quickly reproducing the
problem afterwards.

	Szaka

