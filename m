Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbTFSVWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265967AbTFSVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:22:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3251 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265966AbTFSVWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:22:48 -0400
Subject: Re: 2.5.72: wall-clock time advancing too rapidly?
From: john stultz <johnstul@us.ibm.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Jun 2003 14:30:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 09:10, Andy Pfiffer wrote:
> I have a uniproc P3-800 system running 2.5.72, and time (from that
> system's point of view) is racing ahead rapidly.
> 
> By "racing ahead rapidly", I mean this:
> 
> 	% date ; sleep 60 ; date
> 	Thu Jun 19 09:04:29 PDT 2003
> 	Thu Jun 19 09:05:29 PDT 2003
> 	%
> 
> returns in 35 seconds (measured with my eyeballs and cheap wristwatch).
> 
> Has anyone else seen this?

Well, variants on a theme. Can I get more hardware info? Is this a
laptop? Are we running w/ Speed Step?

thanks
-john


