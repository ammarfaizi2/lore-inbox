Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTE1NYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264068AbTE1NYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:24:52 -0400
Received: from mail.cid.net ([193.41.144.34]:3016 "EHLO mail.cid.net")
	by vger.kernel.org with ESMTP id S264061AbTE1NYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:24:51 -0400
Date: Wed, 28 May 2003 15:37:55 +0200
From: Stefan Foerster <stefan@stefan-foerster.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528133755.GD12914@in-ws-001.cid-net.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de> <3ED4B49A.4050001@gmx.net> <20030528130839.GW845@suse.de> <20030528132758.GB12914@in-ws-001.cid-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030528132758.GB12914@in-ws-001.cid-net.de>
User-Agent: Mutt/1.3.28i
X-Now-Playing: Dusty Springfield - Son of a Preacher Man
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Foerster <stefan@stefan-foerster.de> wrote:
[...]
> Doesn't matter if IDE or SCSI, to be honest, SCSI with the old aic7xxx
> from vanilla 2.4.20 is even worse than IDE.
> 
> My box is up, had only my window manager with some open xterms
> running, nothing which should create any load.

Oh silly me, forgot to include that info: I have  512MB of RAM, an Athlon XP.

Filesystems didn't seem to matter much in my tests, got hangs with
ext2, ext3 and XFS.


Ciao
Stefan
-- 
Stefan Förster                                  Public Key: 0xBBE2A9E9
FdI #44: Verdeckter Fehler - Siemens hat mitentwickelt. (Jörg Pechau)

