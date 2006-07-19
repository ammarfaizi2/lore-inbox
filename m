Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWGSIIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWGSIIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWGSIIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:08:04 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:6152 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S932471AbWGSIID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:08:03 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: XFS breakage in 2.6.18-rc1
Date: Wed, 19 Jul 2006 09:08:30 +0100
User-Agent: KMail/1.9.3
Cc: Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com>
In-Reply-To: <20060719085731.C1935136@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607190908.30727.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 July 2006 23:57, Nathan Scott wrote:
[snip]
> > of programs fail in mysterious ways. I tried to recover using xfs_repair
> > but I feel that my partition is thorougly borked. Of course no data was
> > lost due to backups but still I'd like this bug to be fixed ;-)
>
> 2.6.18-rc1 should be fine (contains the corruption fix).  Did you
> mkfs and restore?  Or at least get a full repair run?  If you did,
> and you still see issues in .18-rc1, please let me know asap.

Just out of interest, I've got a few XFS volumes that were created 24 months 
ago on a machine that I upgraded to 2.6.17 about a month ago. I haven't seen 
any crashes so far.

Assuming I get the newest XFS repair tools on there, what's the disadvantage 
of repairing versus creating a new filesystem? What special circumstances are 
required to cause a crash?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
