Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSJ1Iwb>; Mon, 28 Oct 2002 03:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbSJ1Iwb>; Mon, 28 Oct 2002 03:52:31 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:56783 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S263204AbSJ1Iwa>; Mon, 28 Oct 2002 03:52:30 -0500
Message-Id: <200210280955.g9S9tqi3002027@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 28 Oct 2002 04:55:45 -0500
From: Skip Ford <skip.ford@verizon.net>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       boissiere@adiglobal.com
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
References: <200210272017.56147.landley@trommello.org> <20021028135504.A7384@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028135504.A7384@in.ibm.com>; from vamsi@in.ibm.com on Mon, Oct 28, 2002 at 01:55:04PM +0530
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [141.150.241.241] at Mon, 28 Oct 2002 02:58:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vamsi Krishna S . wrote:
>
> The kprobes home page:
> http://www-124.ibm.com/linux/projects/kprobes

The kprobes homepage says:

 Extensions to kprobes

   kprobes has been developed from the full Dynamic Probes patch. It
   includes the essential mechanism to allow probes to exist in kernel
   space. The RPN Language Interpreter, Watchpoints and User-space probes
   extensions, which are part of the Dynamic Probes Package, will be
   available as add-on patches from the website.
   
   At the moment, we are proposing for kprobes inclusion into the kernel
   which includes the following four patches:
     * kprobes base:
       Provides the interface described above
     * debug register management:
        [snip]
     * kwatch points:
        [snip]
     * user space probes:

The first paragraph seems to say that only the base patch is being
submitted and the watchpoint and user-space extensions can be
retrieved from the site.

But then it goes on to say that you are proposing those for inclusion
also.  I'm confused and I've been using your patches.  Also, that first
paragraph mentions "add-on" patches while all along I thought your
intention was to have enough of dprobes in the kernel so that patching
wasn't necessary.

-- 
Skip
