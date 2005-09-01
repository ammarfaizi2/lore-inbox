Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVIALCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVIALCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVIALCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:02:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932249AbVIALCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:02:35 -0400
Date: Thu, 1 Sep 2005 03:59:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Teigland <teigland@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-Id: <20050901035939.435768f3.akpm@osdl.org>
In-Reply-To: <20050901104620.GA22482@redhat.com>
References: <20050901104620.GA22482@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland <teigland@redhat.com> wrote:
>
> Hi, this is the latest set of gfs patches, it includes some minor munging
>  since the previous set.  Andrew, could this be added to -mm?

Dumb question: why?

Maybe I was asleep, but I don't recall seeing much discussion or exposition
of

- Why the kernel needs two clustered fileystems

- Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
  possibly gain (or vice versa)

- Relative merits of the two offerings

etc.

Maybe this has all been thrashed out and agreed to.  If so, please remind me.
