Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVCHKme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVCHKme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVCHKme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:42:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30700 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261966AbVCHKmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:42:32 -0500
Date: Tue, 8 Mar 2005 11:38:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/3] swsusp: use non-contiguous memory
Message-ID: <20050308103846.GA23640@elf.ucw.cz>
References: <200503042051.54176.rjw@sisk.pl> <200503071232.32141.rjw@sisk.pl> <20050307033905.7efa259e.akpm@osdl.org> <200503071313.07679.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503071313.07679.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 07-03-05 13:13:07, Rafael J. Wysocki wrote:
> On Monday, 7 of March 2005 12:39, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Yes, the Signed-off-by line was missing from the original patch.  Andrew,
> > > should I resubmit it?
> > > 
> > 
> > I dropped lots of those swsusp patches due to various bit of breakage. 
> > Pavel will be redoing all of them sometime, hopefully.
> 
> These patches are a "redone version" of the patch that Pavel submitted
> before and Pavel has acked them already.
> 
> I did my best not to break them, but if they are broken, could you please tell
> me what's wrong with them so that I can fix it?

Just bad timing, I guess. I sent wrong patches, and andrew reacted by
simply waiting for me to catch up with right tree (which is okay, it
was big and not critical).

Now, akpm sent all (?) swsusp updates to Linus, so it should appear in
bk tree later today. If you could regenerate the patches (1/3 will no
longer be needed) and send them to me & l-k. I'll then forward them to
akpm. [He seems to prefer patches to come from my email address :-)]

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
