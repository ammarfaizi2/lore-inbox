Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbVFXWrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVFXWrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbVFXWrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:47:41 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:2837 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S263067AbVFXWqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:46:33 -0400
Date: Fri, 24 Jun 2005 15:45:34 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Petr Baudis <pasky@ucw.cz>
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050624224534.GF31165@ca-server1.us.oracle.com>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624064101.GB14292@pasky.ji.cz>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> Theoretically, dotest should work just fine even if you use Cogito.
> Anyone tested it?

	When I update the OCFS2 git tree, I clone with Cogito and patch
with dotest.  Been doing it for a month or two, no problems.

Joel

-- 

"I think it would be a good idea."  
        - Mahatma Ghandi, when asked what he thought of Western
          civilization

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
