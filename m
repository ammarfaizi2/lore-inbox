Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVIKWFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVIKWFi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVIKWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:05:38 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:64137 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750957AbVIKWFi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:05:38 -0400
Date: Mon, 12 Sep 2005 00:07:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new asm-offsets.h patch problems
Message-ID: <20050911220731.GF2177@mars.ravnborg.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E7E@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E7E@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> >It still leaves of with the original offending IA64_TASK_SIZE,
> >but grep did no tell me where task_struct was defined??
> 
> It is in include/linux/sched.h

Obviously - thanks.
I was so focussed that this was a ia64 typedef for some reasons.

	Sam
