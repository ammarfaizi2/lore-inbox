Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268408AbUHTRiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268408AbUHTRiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268429AbUHTRiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:38:55 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:24635 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268408AbUHTRiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:38:12 -0400
Date: Fri, 20 Aug 2004 21:38:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Hansen <haveblue@us.ibm.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Cc: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ketchup versus patch-kernel
Message-ID: <20040820193835.GB7298@mars.ravnborg.org>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Matt Mackall <mpm@selenic.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1093021608.15662.1228.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093021608.15662.1228.camel@nighthawk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 10:06:48AM -0700, Dave Hansen wrote:
> Since 2.6.8.1 came out, I'm sure a lot of automated tools stopped
> working, ketchup included. 

Can someone please explain to me what is the difference between
patch-kernel and ketchup?

With difference I ask for what problem they solve (and mayby how).
I know very well ketchup uses phython - thats an implementation detail.

Rationale behind the question is if we should include both patch-kernel
and ketchup in the kernel.

	Sam
