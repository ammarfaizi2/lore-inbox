Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266944AbUBGPjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 10:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266947AbUBGPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 10:39:39 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:25511 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266944AbUBGPjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 10:39:36 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] 2.4.25-rc1: Add user friendliness to highmem= option
Date: Sat, 7 Feb 2004 23:38:02 +0800
User-Agent: KMail/1.5.4
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <axboe@suse.de>,
       <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402071007510.28464-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402071007510.28464-100000@chimarrao.boston.redhat.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402072338.05365.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 February 2004 23:08, Rik van Riel wrote:
> On Sat, 7 Feb 2004, Michael Frank wrote:
> 
> > Enclosed is a patch for x86 to make highmem= option easier to use.
> > 
> > - Automates alignment of highmem zone
> > - Fixes invalid highmem settings whether too small or to large
> > - Adds entry in kernel-parameters.txt
> 
> This is awesome!  Thanks.
> 
> Marcelo, could you please apply this ? ;)
> 

Thank you very much for your encouraging response ;)

What is your opinion on shutting down the kernel on
zone alignment errors (applies to all arches) and
the force_bug method it uses to do so?

Regards
Michael

> -- 
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
> 
> 
> 

