Return-Path: <linux-kernel-owner+w=401wt.eu-S1423112AbWLUVSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423112AbWLUVSB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423111AbWLUVSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:18:01 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:58029 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423099AbWLUVSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:18:00 -0500
Subject: Re: Updated Kernel Hacker's guide to git
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
In-Reply-To: <458A73A6.4010805@garzik.org>
References: <4589F9B1.2020405@garzik.org>
	 <1166680407.3636.25.camel@nigel.suspend2.net> <458A73A6.4010805@garzik.org>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 08:17:58 +1100
Message-Id: <1166735878.5906.3.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2006-12-21 at 06:44 -0500, Jeff Garzik wrote:
> Nigel Cunningham wrote:
> > Hi.
> > 
> > On Wed, 2006-12-20 at 22:04 -0500, Jeff Garzik wrote:
> >> I refreshed my git intro/cookbook for kernel hackers, at 
> >> http://linux.yyz.us/git-howto.html
> >>
> >> This describes most of the commands I use in day-to-day kernel hacking. 
> >>   Let me know if there are glaring errors or missing key commands.
> > 
> > Thanks for the work! I'd suggest also saying how to repack and cleanup.
> 
> Yes, I should mention repacking.  When you say cleanup, what 
> specifically do you mean?

Oh, I was just thinking of the related commands - prune-packed,
count-objects, fsck-objects and so on. (I know repack does prune-packed
when you use -d, but it might be handy to mention it anyway... or
not :>)

> > Could also be a good idea to go through the steps for uploading to
> > master.kernel.org or elsewhere?
> 
> Yes, push should be mentioned at the very least.

Nigel

