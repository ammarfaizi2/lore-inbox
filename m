Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbTIIQnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTIIQnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:43:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:46824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262487AbTIIQne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:43:34 -0400
Date: Tue, 9 Sep 2003 09:44:11 -0700
From: Dave Olien <dmo@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Badness in as_completed_request warning
Message-ID: <20030909164411.GA16913@osdl.org>
References: <20030908164802.GA13441@osdl.org> <3F5D4BC9.6020708@cyberone.com.au> <20030909061214.GA15840@osdl.org> <3F5D7B6A.70703@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5D7B6A.70703@cyberone.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Sep 09, 2003 at 05:04:10PM +1000, Nick Piggin wrote:
> 
> Thanks Dave,
> Can you try this one? I can't reproduce the problem here as I don't have
> enough disks unfortunately. Thanks
> 
> Nick

One of OSDL's reasons for existance is to arrange for Linux developers
to have access to larger hardware configurations.  I'm sure you could
get a project machine here at OSDL to do testing of I/O scheduler
modifications, or other testing on a larger machine.  Several other
kernel developers have project machines here at OSDL.

Look at the web page

	http://www.osdl.org/lab_activities/be_an_associate.html

Fill out the web page form to get a login.  send email to Cliffw@osdl.org
and me, and we'll see that it gets handled quickly.

You'd be able to ssh into a front-end machine here at OSDL. It would
give you serial console access to a test machine.  You'd also be able
to power on/power off and reset the test machine, and ssh into the
test machine from that front-end.

Dave
