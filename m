Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbTGKVIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266849AbTGKVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:08:49 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:9121 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266837AbTGKVIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:08:44 -0400
Date: Fri, 11 Jul 2003 15:54:40 -0400
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@work.bitmover.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Strange BK behaviour?
Message-ID: <20030711195440.GY439@phunnypharm.org>
References: <Pine.LNX.4.55L.0307111715400.5537@freak.distro.conectiva> <20030711205532.GB17804@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711205532.GB17804@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 01:55:32PM -0700, Larry McVoy wrote:
> Ahh, it's there, bkbits just isn't showing it because it is an empty merge
> changeset.  That's a bug.  If you care, file a bug on bk/web with a 
> summary like "show merge changesets if they are tagged".

It definitely got down to CVS/SVN.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
