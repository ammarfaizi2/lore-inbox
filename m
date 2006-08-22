Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWHVRAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWHVRAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHVRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:00:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:59106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932141AbWHVRAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:00:46 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
From: Mike Galbraith <efault@gmx.de>
To: vatsa@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
In-Reply-To: <20060822160223.GB12943@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	 <20060820174839.GH13917@in.ibm.com>
	 <1156245036.6482.16.camel@Homer.simpson.net>
	 <20060822101028.GB5052@in.ibm.com>
	 <1156257674.4617.8.camel@Homer.simpson.net>
	 <1156260209.6225.7.camel@Homer.simpson.net>
	 <1156261506.6319.6.camel@Homer.simpson.net>
	 <20060822135056.GB7125@in.ibm.com>
	 <1156269931.4954.12.camel@Homer.simpson.net>
	 <20060822160223.GB12943@in.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 19:09:17 +0000
Message-Id: <1156273757.6143.0.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 21:32 +0530, Srivatsa Vaddagiri wrote:
> On Tue, Aug 22, 2006 at 06:05:31PM +0000, Mike Galbraith wrote:
> > I just did echo "0-1" > cpus.
> 
> "cpus" here is the "cpus" file in "all" cpuset?

Yes.

	-Mike

