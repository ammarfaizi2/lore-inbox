Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVEMIYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVEMIYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVEMIYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:24:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26844 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262298AbVEMIVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:21:47 -0400
Date: Fri, 13 May 2005 09:21:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>, jbohac@suse.cz,
       jbenc@suse.cz
Subject: Re: ipw2100: intrusive cleanups, working this time ;-)
Message-ID: <20050513082143.GA553@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Ketrenos <jketreno@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>, netdev@oss.sgi.com,
	kernel list <linux-kernel@vger.kernel.org>, jbohac@suse.cz,
	jbenc@suse.cz
References: <20050512225026.GA2822@elf.ucw.cz> <4283FA4D.3010208@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4283FA4D.3010208@linux.intel.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 07:52:29PM -0500, James Ketrenos wrote:
> Part of the process we have in place is to try and make sure that the
> versions that get picked up by distros and the majority of users have a
> 'known' level of quality.  As part of that, we only want to get changes
> pushed to -mm and eventual mainline that have gone through regression
> testing.

The only wait to make that works is to opensource the testsuites and allow
the distros to run the QA test themselves.  Except for maybe SuSE no one
will pick up a driver version just because you say so.

p.s. please remove the part of the mail you follow up to that's not relevant
	yo your posting.  thanks.
