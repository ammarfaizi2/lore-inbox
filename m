Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWHWI40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWHWI40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWHWI40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:56:26 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:37019 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750747AbWHWI4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:56:25 -0400
Date: Wed, 23 Aug 2006 10:54:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Subject: Re: Linux 2.6.17.10
In-Reply-To: <20060823084148.GA18098@suse.de>
Message-ID: <Pine.LNX.4.61.0608231054050.375@yvahk01.tjqt.qr>
References: <20060822192727.GA8579@kroah.com> <20060823083504.GA31519@merlin.emma.line.org>
 <20060823084148.GA18098@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Sridhar Samudrala:
>> >       Fix sctp privilege elevation (CVE-2006-3745)
>> 
>> I've seen gazillions of CVE numbers for SCTP over the past months.
>> 
>> Should perhaps SCTP be dropped from the kernel until it has been audited
>> for security by at least two independent parties?
>
>the thing, luckily no one really uses it in the wild :)

If other OS (such as mswin32) supported it, it would indeed get more 
testing.


Jan Engelhardt
-- 
