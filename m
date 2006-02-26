Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWBZCdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWBZCdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 21:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWBZCdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 21:33:39 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:19654 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751174AbWBZCdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 21:33:38 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: nando@ccrma.Stanford.EDU, linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1140917787.24141.78.camel@mindpipe>
References: <1140917787.24141.78.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 18:33:20 -0800
Message-Id: <1140921200.12674.29.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 20:36 -0500, Lee Revell wrote:
> Users report that this patch:
> 
> https://www.redhat.com/archives/fedora-devel-list/2004-June/msg00072.html
> 
> is still needed to eliminate audio underruns for Radeon users.
> 
> Any news on this?

You mean on the plain vanilla stable kernel tree? Users running what?

I'm using 2.6.15-rt18 currently on radeon machines (9250 chipset) with
no problems that I can see. 

-- Fernando


