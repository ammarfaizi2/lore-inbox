Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTE1LTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTE1LTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:19:03 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:37639 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264679AbTE1LTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:19:02 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 13:31:26 +0200
User-Agent: KMail/1.5.2
Cc: axboe@suse.de, kernel@kolivas.org, matthias.mueller@rz.uni-karlsruhe.de,
       manish@storadinc.com, andrea@suse.de, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com>
In-Reply-To: <20030528042700.47372139.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305281331.26959.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 13:27, Andrew Morton wrote:

Hi Akpm,

> > Does the attached one make sense?
> Nope.
nm.

> Guys, you're the ones who can reproduce this.  Please spend more time
> working out which chunk (or combination thereof) actually fixes the
> problem.  If indeed any of them do.
As I said, I will test it this evening. ATM I don't have time to recompile and 
reboot. This evening I will test extensively, even on SMP, SCSI, IDE and so 
on.

ciao, Marc

