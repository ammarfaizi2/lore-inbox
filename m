Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTFKU3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTFKU2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:28:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:28164 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264436AbTFKUXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:23:35 -0400
Date: Wed, 11 Jun 2003 22:37:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jay Denebeim <denebeim@deepthot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build problems with Linux 2.5
Message-ID: <20030611203717.GA2064@mars.ravnborg.org>
Mail-Followup-To: Jay Denebeim <denebeim@deepthot.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:26:33PM -0700, Jay Denebeim wrote:
> (.70, but I doubt that makes a difference)
> 
> Hi guys,
> 
>   I've been way out of kernel compiling for a long time, however I just
> took a job writing device drivers on Linux so I guess I'll be doing quite
> a bit of it again.  I've not built a kernel other than an occasional 'make
> rpm' on redhat since the 2.0 days, so be gentle with me.

Two pointers:
http://www.codemonkey.org.uk/post-halloween-2.5.txt

This is good, and answer your QM_MODULES question + more.
lwn.net - has a good article serie about driver porting to 2.5

	Sam
