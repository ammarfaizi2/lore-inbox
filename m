Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTDWS5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTDWS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:57:47 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:29708 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264369AbTDWS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:57:46 -0400
Date: Wed, 23 Apr 2003 20:09:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
Message-ID: <20030423200951.A5723@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Andreas Gruenbacher <a.gruenbacher@computer.org>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	lsm <linux-security-module@wirex.com>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <1051122958.14761.110.camel@moss-huskers.epoch.ncsc.mil> <20030423194254.A5295@infradead.org> <1051124367.14761.125.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051124367.14761.125.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Apr 23, 2003 at 02:59:27PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 02:59:27PM -0400, Stephen Smalley wrote:
> On Wed, 2003-04-23 at 14:42, Christoph Hellwig wrote:
> > No.  It's not acceptable that the same ondisk structure has a different
> > meaning depending on loaded modules.  If the xattrs have a different
> > meaning they _must_ have a different name.
> 
> Again, I'd suggest that you read the original discussion thread.

Again I did read it and your design doesn't get any better by just
reposting it.

