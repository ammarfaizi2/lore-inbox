Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUEMNRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUEMNRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUEMNRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:17:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54949 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263823AbUEMNRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:17:31 -0400
Date: Thu, 13 May 2004 15:17:30 +0200
From: Jan Kara <jack@suse.cz>
To: Paul P Komkoff Jr <i@stingr.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: might_sleep in quota code path as of 2.6.6-rc2, may be fixed already
Message-ID: <20040513131730.GE3629@atrey.karlin.mff.cuni.cz>
References: <20040512121835.GP13255@stingr.net> <20040512165802.GB32138@atrey.karlin.mff.cuni.cz> <20040513103937.GA19183@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513103937.GA19183@stingr.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Replying to Jan Kara:
> >   Hello,
> > 
> > > Have you seen that?
> >   No. Thanks for the trace. Which kernel do you use?
> 
> that was in 2.6.6-rc2
  OK. I fixed a bug which could cause your problem and the fix is in
2.6.6 so please try that kernel.

						Thanks for report
								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
