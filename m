Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422957AbWJFU6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422957AbWJFU6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422960AbWJFU6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:58:39 -0400
Received: from mail.fieldses.org ([66.93.2.214]:11737 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1422957AbWJFU6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:58:38 -0400
Date: Fri, 6 Oct 2006 16:58:36 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] 2.6.19-rc1 boot failure--ops in mpu401_init?
Message-ID: <20061006205836.GC18026@fieldses.org>
References: <20061006204358.GB18026@fieldses.org> <1160167993.17615.0.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160167993.17615.0.camel@mindpipe>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 04:53:13PM -0400, Lee Revell wrote:
> On Fri, 2006-10-06 at 16:43 -0400, J. Bruce Fields wrote:
> > I also probably won't have time to try a git-bisect in the next few
> > days, though I could try it eventually if it'd help. 
> 
> Thanks for the report.  Problem is known and fixed in later releases.
> See the LKML/alsa-devel thread "Driver core: Don't ignore error returns
> from probing".

OK, thanks.--b.
