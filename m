Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVCKM6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVCKM6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVCKM6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:58:52 -0500
Received: from batleth.sapienti-sat.org ([83.137.98.96]:36756 "EHLO
	batleth.sapienti-sat.org") by vger.kernel.org with ESMTP
	id S262703AbVCKM6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:58:39 -0500
From: juri@koschikode.com (Juri Haberland)
To: pwaechtler@mac.com (Peter Waechtler)
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux dvb alps_tdlb7 removed
In-Reply-To: <aebc44b2e0c42cc9dc0ec0b215c10ec4@mac.com>
X-Newsgroups: local.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.4.27-2-686 (i686))
Message-Id: <20050311125836.BDB721B02B@nx-01.home.sapienti-sat.org>
Date: Fri, 11 Mar 2005 13:58:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <aebc44b2e0c42cc9dc0ec0b215c10ec4@mac.com> you wrote:
> With version 2.6.10 the driver for the tuner frontend from ALPS TDLB7 
> was removed.
> 
> Why do you think that this is a dead file?
> While I'm happy with the work you do for dvb on Linux, and I want to 
> thank you for this anyway, my TV does not work anymore! :(
> 
> I use a TechoTrend Premium card with that frontend on it. It worked 
> fine until 2.6.10.
> Can you put it back into mainline? Is there some work to do for 
> reinsertion?

I think the driver you now need is sp8870. It's just another name for
the same file.

Regards,
Juri
