Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUL0ATS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUL0ATS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUL0ATS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:19:18 -0500
Received: from mxin.widomaker.com ([204.17.220.7]:8969 "EHLO
	mxin.widomaker.com") by vger.kernel.org with ESMTP id S261438AbUL0ATO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:19:14 -0500
Date: Sun, 26 Dec 2004 18:43:42 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd hang while playing a CD in 2.6.10
Message-ID: <20041226234340.GB3806@widomaker.com>
References: <20041225234342.GA5177@widomaker.com> <41CF188D.8090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CF188D.8090404@gmail.com>
User-Agent: Mutt/1.5.4i
X-Spam-Score: -4.9 (----)
X-Spam-Report: This message has been scanned & scored by widomaker.com's mail servers.
	The information added to this message is to allow you to chose whether
	or not you accept this message.  For more information, contact
	helpdesk@widomaker.com or see http://www.widomaker.com/filterspam.html
	Content analysis details:   (-4.9 points, 9.0 required)
	BAYES_00=-4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, 26 Dec 2004 @ 14:01 -0600, John said:

> Can you check a different IDE cable?

I could, but I'm not sure there is a point.

The CD drive functions perfectly as a CD-ROM drive, so I just don't
think the cable could be bad.  

I can burn, rip, and mount CDs just fine.

Playing CDs works fine under Windows, but not Linux 2.6.x.

So far, it seems to be a Linux problem.  More specifically, something
about how gnome-cd controls the CD drive since Totem seems to play CDs
just fine.

My next step is to get a full trace of gnome-cd to at see more clearly
where the problem occurs.  Otherwise I really don't know how to debug
something like this.

I thought someone else might have seen it, or want further details.

> I remember having something like that with my hard drive.

You couldn't play audio tracks from the CD you put in it? :-)


-- 
shannon "AT" widomaker.com -- ["And in billows of might swell the Saxons
before her,-- Unite, oh unite!	Or the billows burst o'er her!" -- Downfall
of the Gael]
