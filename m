Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTFKWDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTFKWDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:03:00 -0400
Received: from lorien.emufarm.org ([66.93.131.57]:2029 "EHLO
	lorien.emufarm.org") by vger.kernel.org with ESMTP id S264536AbTFKWC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:02:58 -0400
Date: Wed, 11 Jun 2003 15:16:41 -0700
From: Danek Duvall <duvall@emufarm.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7-ac1
Message-ID: <20030611221641.GD20063@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <20030611204828.GC8952@lorien.emufarm.org> <200306112209.h5BM9ub21810@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306112209.h5BM9ub21810@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What bits should I start hacking away to narrow down the problem, or is
> > this known?
> 
> See if its a specific in or out instruction in the rtc driver 

What's the best way to do that?  Any way do that in userspace, or will I
have to hack the driver code?  If the latter, what do I do?

Thanks,
Danek
