Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265749AbUGCBIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbUGCBIc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 21:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUGCBIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 21:08:32 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:4369 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265749AbUGCBIb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 21:08:31 -0400
Date: Sat, 3 Jul 2004 03:08:29 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anthony Ewell <aewell@gbis.com>
Cc: bug-parted@gnu.org, linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics
In-Reply-To: <40E5FFD2.7040804@gbis.com>
Message-ID: <Pine.LNX.4.21.0407030259460.19875-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Jul 2004, Anthony Ewell wrote:
> 
>     By any chance is the the same bug that is causing FC2's installer
> to trash dual booting to Windows?
> 
>         https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115980
> 
>     If it is, it is causing an ever living nightmare out in the FC2
> world.   The above link has zillions of painfully documented
> technical experiences, with work-a-rounds, that may help in
> troubleshooting this problem.  I personally am holding off on
> upgrading to FC2 until bug 115980 is fixed: I can not afford to
> get my Windows partitions trashed (I know, the partition are okay,
> I just can not boot to them).
> 
>     If not, maybe bug 115980 will have something else of help.

Yes, Fedora, SUSE, Mandrake, new Debian install, etc virtually everybody
has this problem but since there are many bugs in parted it manifests
different way so it's indeed pretty confusing (people look for _the_ bug
but there are many).

http://portal.suse.com/sdb/en/2004/05/fhassel_windows_not_booting91.html
https://qa.mandrakesoft.com/show_bug.cgi?id=7959

	Szaka

