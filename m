Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTE2VhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTE2VhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:37:24 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262813AbTE2VhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:37:21 -0400
Subject: Re: Nightly regression runs against current bk tree
From: Craig Thomas <craiger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, peloquin@austin.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030529212929.GA11309@wotan.suse.de>
References: <3ED66C83.8070608@austin.ibm.com.suse.lists.linux.kernel>
	 <p73smqx791m.fsf@oldwotan.suse.de>
	 <20030529.142515.08325314.davem@redhat.com>
	 <20030529212929.GA11309@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1054245025.1957.113.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 May 2003 14:50:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 14:29, Andi Kleen wrote:
> On Thu, May 29, 2003 at 02:25:15PM -0700, David S. Miller wrote:
> >    From: Andi Kleen <ak@suse.de>
> >    Date: 29 May 2003 23:11:17 +0200
> >    
> >    David, what do you think?
> >    
> > Would it have a single poster?
> 
> OSDL, Mark's IBM team and possible LTP ?
> 
> I assume there will be more once the list exists; automated regression 
> tests seem to be currently in fashion.
> 
> -Andi
> -

OSDL has a linux stabilization web page where several tests are run
automatically when a new kernel is built.  It currently runs Linus'
kernel as well as the -mm series.  We do run LTP, I/O tests, memory
tests, reaim, and database tests as part of an automated regression 
run. Some of you are familiar with the web page, but for those who are
not, it is located here: http://www.osdl.org/projects/linstab/  

In addition, there are links to other sites, most notably IBM's LTC
test results.

We have just completed a physical move to a new office and we believe
we have all of our systems working again, so test results for the
latest kernels are a bit behind.  We hope to have completed runs for
all tests by the weekend.  Note, we are experiencing some test failures
but we suspect it is due to the move and not the kernels at the moment.

-- 
Craig Thomas
craiger@osdl.org

