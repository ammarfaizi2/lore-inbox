Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268503AbUHTRsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268503AbUHTRsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUHTRsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:48:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39621 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268503AbUHTRsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:48:01 -0400
Subject: Re: ketchup versus patch-kernel
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040820193835.GB7298@mars.ravnborg.org>
References: <1093021608.15662.1228.camel@nighthawk>
	 <20040820193835.GB7298@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1093024052.15662.1245.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 10:47:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 12:38, Sam Ravnborg wrote:
> On Fri, Aug 20, 2004 at 10:06:48AM -0700, Dave Hansen wrote:
> > Since 2.6.8.1 came out, I'm sure a lot of automated tools stopped
> > working, ketchup included. 
> 
> Can someone please explain to me what is the difference between
> patch-kernel and ketchup?

In my view, there's no basic difference in their intention: turn one
kernel version into another.  Although, ketchup does handle a few more
things like downloads, gpg, and a wider variety of trees like -mm, -mjb
and -tiny.  
-- Dave

