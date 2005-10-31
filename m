Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVJaDec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVJaDec (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVJaDec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:34:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45509 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932266AbVJaDec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:34:32 -0500
Date: Mon, 31 Oct 2005 03:34:26 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Paul Jackson <pj@sgi.com>
Cc: ak@suse.de, tytso@mit.edu, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051031033426.GT7992@ftp.linux.org.uk>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <p73r7a4t0s7.fsf@verdi.suse.de> <20051030213221.GA28020@thunk.org> <200510310145.43663.ak@suse.de> <20051031001810.GQ7992@ftp.linux.org.uk> <20051030191402.669273d5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030191402.669273d5.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 07:14:02PM -0800, Paul Jackson wrote:
> I think you are exagerating.
> 
> It builds on most configs most of the time in my experience.  If I
> haven't tried a crosstool rebuild of the several defconfig arch's in a
> week, I might expect one of the less popular archs to drop out, usually
> for something so easy even I can figure some sort of fix or workaround.

Try allmodconfig for a change...  I'm doing that for mainline on a regular
basis and even that turns into considerable amount of time.  I have tried
that for -mm and had to give up.
