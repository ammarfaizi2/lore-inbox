Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbUKQTUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbUKQTUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUKQTS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:18:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9615 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262423AbUKQTSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:18:03 -0500
Date: Wed, 17 Nov 2004 20:00:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041117190055.GC6952@openzaurus.ucw.cz>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please consider adding the FUSE filesystem to the mainline kernel.
> 
> FUSE exports the filesystem functionality to userspace.  The
> communication interface is designed to be simple, efficient, secure
> and able to support most of the usual filesystem semantics.

Coda should do the job, too... What are advantages of FUSE over Coda?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

