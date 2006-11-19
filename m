Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756818AbWKSRpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbWKSRpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbWKSRpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:45:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49365 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1756818AbWKSRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:45:01 -0500
Subject: Re: Sluggish system responsiveness on I/O
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Christian <christiand59@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1163922694.7504.42.camel@Homer.simpson.net>
References: <200611181412.29144.christiand59@web.de>
	 <1163922694.7504.42.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 12:44:47 -0500
Message-Id: <1163958288.22176.82.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 08:51 +0100, Mike Galbraith wrote:
> That makes sense, I/O tasks don't generally hold the cpu for extended
> periods, whereas a cpu bound task does.

So what can we do about I/O intensive tasks that also want a lot of CPU,
for example, the bloatier Gnome/KDE apps?  Evolution is the worst for
me.

Lee  

