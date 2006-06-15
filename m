Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWFOH5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWFOH5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWFOH5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:57:14 -0400
Received: from mail.gmx.net ([213.165.64.21]:31418 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751326AbWFOH5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:57:13 -0400
X-Authenticated: #14349625
Subject: Re: bad command responsiveness Proliant DL 585
From: Mike Galbraith <efault@gmx.de>
To: david@dworf.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44910E5B.50704@dworf.com>
References: <448FC1CE.9090108@dworf.com>
	 <1150278161.7994.13.camel@Homer.TheSimpsons.net> <449060EE.60608@dworf.com>
	 <1150353862.8097.61.camel@Homer.TheSimpsons.net> <44910E5B.50704@dworf.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 10:00:50 +0200
Message-Id: <1150358450.8638.12.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 09:38 +0200, David Osojnik wrote:
> Hello,
> 
> IT Works perfect when setting noatime,nodiratime on the partition!!

That's good to hear... sort of.
> 
> can i try anything else? what does this actually mean?

Besides having a constipated journal sucks rocks? ;-)  Dunno.  You could
try a different elevator as a shot in the dark - eliminate something.

	-Mike

