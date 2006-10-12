Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWJLENW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWJLENW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 00:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWJLENW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 00:13:22 -0400
Received: from thunk.org ([69.25.196.29]:8875 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751068AbWJLENV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 00:13:21 -0400
Date: Wed, 11 Oct 2006 20:42:44 -0400
From: Theodore Tso <tytso@mit.edu>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/67] 2.6.18-stable review
Message-ID: <20061012004244.GA9252@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20061011210310.GA16627@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 02:03:10PM -0700, Greg KH wrote:
> And yes, we realize that this is a large number of patches, sorry...

I number of these patches were cleanups, such as removing code betewen
#if 0, removing header files from being exported, etc.  Not bad
things, but I wouldn't have thought it would have met the criteria for
being added to -stable.  Are you intentionally relaxing the criteria?

Regards,

						- Ted

