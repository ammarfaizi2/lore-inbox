Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUFRBW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUFRBW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUFRBW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:22:28 -0400
Received: from sol.linkinnovations.com ([203.94.173.142]:49538 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S264915AbUFRBV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:21:58 -0400
Date: Fri, 18 Jun 2004 11:21:50 +1000
From: CaT <cat@zip.com.au>
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618012150.GA8706@zip.com.au>
References: <40D232AD.4020708@opensound.com> <77709e76040617180749cd1f09@mail.gmail.com> <40D24163.5000006@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D24163.5000006@opensound.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 06:12:03PM -0700, 4Front Technologies wrote:
> Our software doesn't need any patches like Win4Lin. Our software works
> off the standard Linux kernel sources (if they were intact).
> 
> THe problem here is that SuSE has gone and changed all the kernel headers
> so that now software doesn't compile. It does work if you were using
> the stock kerne.org sources.

Personally I'd make sure the drivers worked with the stock kernel and if
they don't work with a distro's release then the bug is theirs. File it
with them, include detail and see what happens. If they choose to deviate
from the default by such a large degree that what is correctly written
and works with the default no longer works with them, the ball is in their
court.

If need be, tell them you'll accept patches. :)

Just my 2c.

-- 
    Red herrings strewn hither and yon.
