Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTEHTqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbTEHTqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:46:24 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:18952 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262056AbTEHTqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:46:23 -0400
Date: Thu, 8 May 2003 20:58:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508205837.A21329@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Jesse Pollard <jesse@cats-chateau.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305081546_MC3-1-3809-363E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305081546_MC3-1-3809-363E@compuserve.com>; from 76306.1226@compuserve.com on Thu, May 08, 2003 at 03:43:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 03:43:38PM -0400, Chuck Ebbert wrote:
> > HSM has existed on UNIX based machines for a long time.
> 
>   Show me three HSM implementations for Linux and I'll show you three
> different mechanisms. :)

http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/linux/fs/xfs/dmapi/

for the XFS dmapi implementaion.  Both SGI and IBM will sell you full
fledged HSM implementations built ontop of that..

