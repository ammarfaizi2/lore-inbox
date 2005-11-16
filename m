Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbVKPTTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbVKPTTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbVKPTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:19:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21421 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751507AbVKPTTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:19:37 -0500
Date: Wed, 16 Nov 2005 19:10:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Gross, Mark" <mark.gross@intel.com>
Cc: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051116191051.GG2193@spitz.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I worry that this is just adding more thrash to a historically unstable
> implementation.  How long do we users have to wait for a swsusp
> implementation where we don't have to worry about breaking from one
> kernel release to the next?

What unstable implementation? swsusp had very little regressions over past
year or so. Drivers were different story, but nothing changes w.r.t. drivers.

								Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

