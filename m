Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWA1TWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWA1TWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWA1TWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:22:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58905 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750726AbWA1TWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:22:36 -0500
Date: Sat, 28 Jan 2006 20:19:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       76306.1226@compuserve.com, nickpiggin@yahoo.com.au
Subject: Re: [patch 06/12] elevator=as back-compatibility
Message-ID: <20060128191932.GE9750@suse.de>
References: <20060128020629.908825000@press.kroah.org> <20060128022102.GG17001@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128022102.GG17001@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Greg KH wrote:
> 2.6.15.2 -stable review patch.  If anyone has any objections, please let 
> us know.

Well the patch is trivial enough, but I don't see it fitting the stable
criteria to be honest. You would have needed this since 2.6.10 stable,
and it's not fixing an oops or anything.

So I'd NAK this for 2.6.15.x

-- 
Jens Axboe

