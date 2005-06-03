Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVFCBju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVFCBju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 21:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVFCBju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 21:39:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29897 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261479AbVFCBjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 21:39:48 -0400
Date: Thu, 2 Jun 2005 18:39:46 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Support multiply-LUN devices in ub
Message-Id: <20050602183946.035651ca.zaitcev@redhat.com>
In-Reply-To: <20050602193715.GA1860@kroah.com>
References: <20050501160540.5b2f4e61.zaitcev@redhat.com>
	<20050502230452.GA5186@kroah.com>
	<20050602095651.351eca48.zaitcev@redhat.com>
	<20050602193715.GA1860@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005 12:37:16 -0700, Greg KH <greg@kroah.com> wrote:

> It's showing up in the -mm tree, right?  I held off sending this to
> Linus as I thought it didn't fit into the "bugfix" only type of patch
> that we should be sending so late in the -rc series.  Granted the -rc
> series is taking forever...

Yes, I take it into account when Linus or Marcelo ask to hold features.
In this case, however, it was ready for the immediate post-2.6.11 develoment
window and due to unfortunate circumstances it missed that window.
I do not claim that it's a bugfix, and I'm not shameless enough to ask
this in 2.6.11.X.

> So, do you want me to push it to him now?  It's your choice.

I think it's better.

-- Pete
