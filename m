Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTEFQJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTEFQJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:09:30 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:44045
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263914AbTEFQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:09:28 -0400
Date: Tue, 6 May 2003 09:21:53 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac2 NFS close-to-open question
Message-ID: <20030506162153.GH8350@matchmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
References: <20030427151201.27191.qmail@web12802.mail.yahoo.com> <shshe8k6ijs.fsf@charged.uio.no> <20030506022813.GB8350@matchmail.com> <16055.44973.106804.436859@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16055.44973.106804.436859@charged.uio.no>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 02:50:53PM +0200, Trond Myklebust wrote:
> I'm confused. Are the rmap patches making changes to lockd?
> I certainly don't see the above errors in standard 2.4.21-rc1.

Ok, I'll test with standard rc1...

Oh and one more thing, both have the debian freeswan kernel patch applied.

I'll try again without any patches.
