Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVEDPMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVEDPMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVEDPMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 11:12:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20138 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261866AbVEDPMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 11:12:37 -0400
Date: Wed, 4 May 2005 16:12:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
Message-ID: <20050504151231.GA24105@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
	Nathan Scott <nathans@sgi.com>, Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
References: <20050430164303.6538f47c.akpm@osdl.org> <20050503133759.GA7647@ip68-225-251-162.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050503133759.GA7647@ip68-225-251-162.oc.oc.cox.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 06:37:59AM -0700, Barry K. Nathan wrote:
> I would like to see the following patch added to -mm:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111326617622941&w=2
> 
> (I'm guessing that Nathan Scott will need to resubmit it with proper
> changelog information.)
> 
> The patch fixes a problem where compiling XFS into the kernel (as
> opposed to a module) causes swsusp resumes to be waaay slower than they
> should be.
> 
> It's been tested and found to work by Pavel Machek:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111331702916365&w=2
> as well as myself:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111330749723995&w=2
> and I've been running with it for the last couple of weeks now with no
> problems.

Nathan is on paternity leave the next weeks, I'll send Andrew a bunch of
XFS updates one of the next days.
