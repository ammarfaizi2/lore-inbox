Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWJJR7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWJJR7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWJJR7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:59:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:38811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964923AbWJJR7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:59:49 -0400
Date: Tue, 10 Oct 2006 10:59:22 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Michael Krufky <mkrufky@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 00/19] 2.6.17-stable review
Message-ID: <20061010175922.GA9060@kroah.com>
References: <20061010171350.GA6339@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 10:13:50AM -0700, Greg KH wrote:
> This is the start of the stable review cycle for the 2.6.17.14 release.
> There are 19 patches in this series, all will be posted as a response to
> this one.  If anyone has any issues with these being applied, please let
> us know.  If anyone is a maintainer of the proper subsystem, and wants
> to add a Signed-off-by: line to the patch, please respond with it.
> 
> These patches are sent out with a number of different people on the Cc:
> line.  If you wish to be a reviewer, please email stable@kernel.org to
> add your name to the list.  If you want to be off the reviewer list,
> also email us.
> 
> Responses should be made by Thursday, Octover 12, 18:00:00 UTC.
> Anything received after that time might be too late.

An all-in-one patch for this can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.17.14-rc1.gz
if anyone wants to test this out that way.

Also, this is probably going to be the last 2.6.17-stable release,
unless there is something major that we are missing here in this one.

thanks,

greg k-h
