Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266443AbUFUXHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUFUXHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUFUXHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 19:07:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:23714 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266443AbUFUXGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 19:06:54 -0400
Subject: Re: BUG?:   G5 not using all available memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40D76200.4080804@nortelnetworks.com>
References: <1087855279.22687.33.camel@gaston>
	 <40D76200.4080804@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1087858881.22687.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 18:01:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 17:32, Chris Friesen wrote:
> Benjamin Herrenschmidt wrote:
> > On Mon, 2004-06-21 at 16:11, Chris Friesen wrote:
> >  > I've got a G5 with 2GB of memory, running 2.6.7, ppc architecture 
> > (not ppc64),
> >  > with the following config options (let me know if others are relevent)
> > 
> > Do you have CONFIG_HIGHMEM enabled ?
> 
> Yes, CONFIG_HIGHMEM is turned on.  I can send you the full config if you like.
> 
> Sorry, missed including that in the report.

Send me the full dmesg log and the output of /proc/meminfo

Ben.


