Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264028AbUD2Jwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbUD2Jwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUD2Jwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:52:53 -0400
Received: from gprs214-162.eurotel.cz ([160.218.214.162]:14720 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262175AbUD2Jww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:52:52 -0400
Date: Thu, 29 Apr 2004 11:52:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Timothy Miller <miller@techsource.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040429095237.GC390@elf.ucw.cz>
References: <408951CE.3080908@techsource.com> <c6bjrd_pms_1@news.cistron.nl> <20040423174146.GB5977@thunk.org> <20040427203426.GB6116@openzaurus.ucw.cz> <409036C4.7030102@techsource.com> <20040429094644.GA6098@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429094644.GA6098@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've always felt that way, but every time I mention it, people tell me 
> > it's not worth the CPU overhead.  For many years, I have felt that there 
> > should be an IP socket type which was inherently compressed.
> 
> Ever heard of ssh? ;)

Its too high level, and if you want compression but not encryption
that's tricky to do.

> Depending on speed of network and cpus involved, scp can be faster
> than nfs.

Well... but that's due to nfs being broken, right?
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
