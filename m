Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266985AbTHER1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbTHER1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 13:27:40 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:47341 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266985AbTHER1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 13:27:39 -0400
Date: Tue, 5 Aug 2003 13:26:19 -0400
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@work.bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK2CVS problem (fixed)
Message-ID: <20030805172619.GL500@phunnypharm.org>
References: <20030805154131.GA20234@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805154131.GA20234@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 08:41:31AM -0700, Larry McVoy wrote:
> Several people pointed out problems in the BK2CVS trees.  I spent this
> morning checking things over and there were indeed some out of date files.
> I've fixed those up and put in place validation tools which should ensure
> that this does not happen again.

Does this only affect 2.5, and do I need to make bkcvs2svn rebuild from
scratch?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
