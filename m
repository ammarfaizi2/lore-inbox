Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTDDNYL (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTDDNTs (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:19:48 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:52748 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263530AbTDDNTV (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:19:21 -0500
Date: Fri, 4 Apr 2003 14:30:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why moving driver includes ?
Message-ID: <20030404143048.A25147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Ulrich Drepper <drepper@redhat.com>,
	James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org
References: <mailman.1049324411.25620.linux-kernel2news@redhat.com> <200304030045.h330jok10685@devserv.devel.redhat.com> <3E8B8F31.5030407@redhat.com> <20030402204026.A15082@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030402204026.A15082@devserv.devel.redhat.com>; from zaitcev@redhat.com on Wed, Apr 02, 2003 at 08:40:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 08:40:26PM -0500, Pete Zaitcev wrote:
> I can see your point, but imagine how many packages this is
> going to create. Shall we plead with Arjan to maintain
> glibc-kernelheaders as a community package, to be a clearinghouse
> for these things?

Yes.  It would be nice to have a tarball of it on kernel.org instead
of only the SRPM on rawhide, btw..

