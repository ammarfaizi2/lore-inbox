Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTDFVEP (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbTDFVEP (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:04:15 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:60863 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263087AbTDFVEO (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:04:14 -0400
Date: Mon, 07 Apr 2003 09:12:41 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: swsusp - 2.5.66 incremental
In-reply-to: <20030406182016.GA17666@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049663561.3199.29.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049537149.1709.6.camel@laptop-linux.cunninghams>
 <20030406182016.GA17666@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 06:20, Pavel Machek wrote:
> You really should have moved it to the driver model... having #ifdef
> in suspend.c for every driver would be very ugly.

Sorry. I thought that was the maintainer's job.

Regards,

Nigel

