Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVG3LzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVG3LzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVG3LzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:55:15 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:29375 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263053AbVG3LzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:55:11 -0400
Date: Sat, 30 Jul 2005 13:52:04 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why dump_stack results different so much?
Message-ID: <20050730115204.GA2732@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
References: <4ae3c140507291327143a9d83@mail.gmail.com> <20050729203403.GA30603@outpost.ds9a.nl> <4ae3c140507291400230ca65c@mail.gmail.com> <20050729212221.GA32570@outpost.ds9a.nl> <4ae3c140507291710489dd9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140507291710489dd9a@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 08:10:32PM -0400, Xin Zhao wrote:
> Thanks. I will try. The only problem I have right now is I am using
> Xenolinux instead of standard Linux kernel, I cannot see the option to
> enable the frame pointer.  But I will figure out how to enable that.

If you ever report something odd again, remember to inform the readers here
of any odd patches you are running with; they might be the *cause* of what
you are seeing!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
