Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWC1B1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWC1B1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWC1B1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:27:24 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38786 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751194AbWC1B1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:27:24 -0500
Subject: Re: HZ != 1000 causes problem with serial device shown by
	git-bisect
From: Lee Revell <rlrevell@joe-job.com>
To: Greg Lee <glee@swspec.com>
Cc: linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk
In-Reply-To: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
References: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 20:27:19 -0500
Message-Id: <1143509240.1792.337.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 18:46 -0500, Greg Lee wrote:
> I have also tried a number of other kernels and the problem exists all
> the way to 2.6.15.6
> but is fixed in 2.6.16, so I am going to git-bisect 2.6.15.6 to
> 2.6.16, but I thought I
> would get this message out now in case someone has an inkling of what
> the problem is. 

If it's fixed in 2.6.16, what's the problem?  It's not as if we can go
back and fix those old kernels...

Lee

