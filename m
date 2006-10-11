Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWJKVh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWJKVh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161524AbWJKVh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:37:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161390AbWJKVhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:37:55 -0400
Date: Wed, 11 Oct 2006 17:36:48 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/67] 2.6.18-stable review
Message-ID: <20061011213648.GC32371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20061011210310.GA16627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 02:03:10PM -0700, Greg KH wrote:
 > This is the start of the stable review cycle for the 2.6.18.1 release.
 > There are 67 patches in this series, all will be posted as a response to
 > this one.  If anyone has any issues with these being applied, please let
 > us know.  If anyone is a maintainer of the proper subsystem, and wants
 > to add a Signed-off-by: line to the patch, please respond with it.
 > 
 > These patches are sent out with a number of different people on the Cc:
 > line.  If you wish to be a reviewer, please email stable@kernel.org to
 > add your name to the list.  If you want to be off the reviewer list,
 > also email us.
 > 
 > Responses should be made by Friday, October 13, 20:00:00 UTC.  Anything
 > received after that time might be too late.
 > 
 > And yes, we realize that this is a large number of patches, sorry, we
 > have been a bit slow in responding lately.  If there are any patches
 > that have been sent to us for the 2.6.18-stable tree, that are not in
 > this series, please resend them, as we think we are finally caught up
 > with this work.
 > 
 > An all-in-one patch for this series can be found at:
 > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.18.1-rc1.gz
 > if anyone wants to test this out that way.

Is it intentional that this adds a include/linux/utsrelease.h ?
I don't see any patch that adds it in the review mails, but its there in the gz.

	Dave

-- 
http://www.codemonkey.org.uk
