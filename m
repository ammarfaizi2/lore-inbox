Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVAMQo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVAMQo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVAMQnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:43:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29156 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261225AbVAMQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:41:02 -0500
Subject: Re: Kernel releases for security updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregory Boyce <gboyce@badbelly.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501121340560.20156@buddha.badbelly.com>
References: <Pine.LNX.4.61.0501121340560.20156@buddha.badbelly.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105629033.4664.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-12 at 19:45, Gregory Boyce wrote:
> be very interested in being able to run a kernel for extended lengths of 
> time, but most of the discussion on point releases has been about getting 
> a 2.6.X.1 while 2.6.X+1 is still in it's pre stages.  What about the 
> people running 2.6.X-1?  Can they expect to get a point release for 
> security updates?

For -ac I'll support just the current release unless there are real
stability problems or a hole occurs just as Linus puts out a new release
and there isn't enough test data to see what needs fixing in it in which
case I'll fix both.

Alan

