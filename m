Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUF3SrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUF3SrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 14:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUF3SrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 14:47:00 -0400
Received: from linux.us.dell.com ([143.166.224.162]:14195 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266806AbUF3SpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 14:45:05 -0400
Date: Wed, 30 Jun 2004 13:45:01 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Tim Moore <linux-kernel@nsr500.net>
Cc: linux-kernel@vger.kernel.org, linux-kernel-digest-admin@lists.us.dell.com
Subject: Re: list digest / non-digest delivery problems?
Message-ID: <20040630184501.GB17774@lists.us.dell.com>
References: <40E304E2.4060807@nsr500.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E304E2.4060807@nsr500.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 11:22:26AM -0700, Tim Moore wrote:
> Hi;
> 
> After LK switched to digest-only some time back

meaning you're subscribed to linux-kernel-digest or
linux-kernel-daily-digest at lists.us.dell.com, so this clearly isn't
an issue with vger.kernel.org, right?

> I wrote an awk digest expander since I manage the list volume by
> filtering on key words in the subject field.  Recently some messages
> with headers indicating a digest are actually coming through as
> individuals which really tarts things up.

Hmmm.  Nothing has changed on lists.us.dell.com regarding these lists in
quite a while.  Can you provide an example message that you believe is
incorrect?

The linux-kernel-digest list sends one digest every 100KB, which I
think is also near the vger single message size limit.  Any chance
what came through was a single message, yet still wrapped in a digest?

 
> While the digest expander is my problem, keying on reliable email headers 
> it is significantly easier than coding logic to tell if the message is a 
> real digest or an individual message.

They'll have the normal mailman list headers on every message, can't
you use those?


> It would be very helpful to let the group know if there is a problem
> with digests and if the headers will accurately reflect the message
> content.

This is the first I've heard of any problems with the digester in a
long time.  Please provide an example message as requested above, and
I'll look into it.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
