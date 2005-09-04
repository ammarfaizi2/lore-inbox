Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVIDUeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVIDUeE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIDUeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:34:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3297 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751119AbVIDUeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:34:02 -0400
Date: Sun, 4 Sep 2005 22:33:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Teigland <teigland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050904203344.GA1987@elf.ucw.cz>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <20050903051841.GA13211@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903051841.GA13211@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - read-only mount
> - "specatator" mount (like ro but no journal allocated for the mount,
>   no fencing needed for failed node that was mounted as specatator)

I'd call it "real-read-only", and yes, that's very usefull
mount. Could we get it for ext3, too?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
