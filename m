Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTFBJrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTFBJrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:47:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3540 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262100AbTFBJqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:46:07 -0400
Date: Mon, 2 Jun 2003 15:32:04 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Warren Togami <warren@togami.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 kernel BUG include/linux/dcache.h:271!
Message-ID: <20030602100204.GE1256@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1054545600.2020.602.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054545600.2020.602.camel@laptop>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 09:21:31AM +0000, Warren Togami wrote:
> Hardware:
> Sony Vaio FXA36 Athlon laptop
> Red Hat Linux Rawhide 
> 
> After 5 days of uptime on 2.5.70, I noticed this in my dmesg.  I don't
> know what I was doing at the time when this happened.  Known bug?  Let
> me know if you want more information about my hardware/software setup.
> 
Hi Togami,

It will be nice if you can provide some information regarding
the filesystem set up you have in your system. Like which filesystem
you were using.

Are you able to recreate this problem?.

Thanks 
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
