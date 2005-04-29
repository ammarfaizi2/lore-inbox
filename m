Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbVD2Uzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbVD2Uzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVD2UzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:55:06 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:44339 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262976AbVD2UyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:54:13 -0400
Date: Fri, 29 Apr 2005 22:54:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: i386 'make install' behavior change
Message-ID: <20050429205443.GA8699@mars.ravnborg.org>
References: <1114797161.9140.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114797161.9140.22.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:52:41AM -0700, Dave Hansen wrote:
> Hi Sam,
> 
> I noticed in 2.6.12-rc3 that 'make install' doesn't depend on vmlinux.
> I first noticed this in -mm, and it was discussed a bit here:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111083577531995&w=2
> 
> Could you please push that patch to Linus before 2.6.12 finalizes?

It's on the plate for this weekend.

	Sam
