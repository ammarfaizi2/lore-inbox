Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVBKDSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVBKDSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 22:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVBKDSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 22:18:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43735 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262094AbVBKDSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 22:18:49 -0500
Date: Thu, 10 Feb 2005 22:18:23 -0500
From: Bill Nottingham <notting@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211031823.GE29375@nostromo.devel.redhat.com>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050211004033.GA26624@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211004033.GA26624@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH (gregkh@suse.de) said: 
> I'd like to announce, yet-another-hotplug based userspace project:
> linux-ng.  This collection of code replaces the existing linux-hotplug
> package with very tiny, compiled executable programs, instead of the
> existing bash scripts.
> 
> It currently provides the following:
> 	- a /sbin/hotplug multiplexer.  Works identical to the existing
> 	  bash /sbin/hotplug.

How does this interact with current usage of udevsend as the hotplug
multiplexer?

Bill
