Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbUKLH6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbUKLH6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 02:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUKLH6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 02:58:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43907 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262480AbUKLH6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 02:58:11 -0500
Date: Fri, 12 Nov 2004 08:58:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Fix sysdev time support
Message-ID: <20041112075810.GB6307@atrey.karlin.mff.cuni.cz>
References: <1100213485.6031.18.camel@desktop.cunninghams> <1100213785.6031.29.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100213785.6031.29.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Make time_suspend and time_resume call get_cmos_time once only, so as to
> eliminate unnecessary 1 second delays in suspending and resuming.

Looks okay to me.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
