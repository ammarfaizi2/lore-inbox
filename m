Return-Path: <linux-kernel-owner+w=401wt.eu-S932266AbXAIRQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbXAIRQY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbXAIRQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:16:24 -0500
Received: from cs.columbia.edu ([128.59.16.20]:60112 "EHLO cs.columbia.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932266AbXAIRQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:16:23 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Shaya Potter <spotter@cs.columbia.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jan Kara <jack@suse.cz>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <1168362231.6054.38.camel@lade.trondhjem.org>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	 <1168229596875-git-send-email-jsipek@cs.sunysb.edu>
	 <20070108111852.ee156a90.akpm@osdl.org>
	 <20070108231524.GA1269@filer.fsl.cs.sunysb.edu>
	 <20070109121552.GA1260@atrey.karlin.mff.cuni.cz>
	 <1168360219.6054.14.camel@lade.trondhjem.org>
	 <1168360893.5024.38.camel@localhost.localdomain>
	 <1168362231.6054.38.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 12:11:23 -0500
Message-Id: <1168362683.5024.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 12:03 -0500, Trond Myklebust wrote:

> I'm saying that at the very least it should not Oops in these
> situations. As to whether or not they are something you want to handle
> more gracefully, that is up to you, but Oopses are definitely a
> showstopper.

I don't think anyone involved disagrees.  Any oops is a bug that has to
be fixed.

