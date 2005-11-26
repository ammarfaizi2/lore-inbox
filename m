Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVKZXDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKZXDq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKZXDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 18:03:46 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:33517 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750772AbVKZXDq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 18:03:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ctr7osGfk236OSEec8wIJAgG2q6diTolhByiDUWYLnRi5vP18m9dqKW5PiwSSn2bu2cik+C6iWoa2ixhIr5hOngu1QmCpJPGNUk+N7Ry1pj+S+nCi2kAUWPdqm6sKOZ4NeZOVIqLi9I4g4v/v/5KqPOLP4B1c73cIOm+5S884lo=
Message-ID: <fb1c016d0511261503w534d2dc2k9a350fc9bca844d6@mail.gmail.com>
Date: Sun, 27 Nov 2005 00:03:44 +0100
From: Mark van der Made <streamlife@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 00/19] Adaptive read-ahead V8
Cc: Diego Calleja <diegocg@gmail.com>, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1132947083.20390.53.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051125151210.993109000@localhost.localdomain>
	 <20051125164317.c42c0639.diegocg@gmail.com>
	 <1132947083.20390.53.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-11-25 at 16:43 +0100, Diego Calleja wrote:
> > Recently, a openoffice hacker wrote in his blog that the kernel was
> > culprit of applications not starting as fast as in other systems.
>
> Useless without a link ;-)
>
I think Diego refers to Michael Meeks blog:
http://www.gnome.org/~michael/activity.html#2005-11-04
Michael Meek also speaks about kernel issues in an interview in Linux
Format 72 (nov 2005).

Mark
