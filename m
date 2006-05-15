Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWEOTPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWEOTPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWEOTPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:15:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:28615 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965187AbWEOTPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:15:11 -0400
Message-ID: <4468D33D.3070504@garzik.org>
Date: Mon, 15 May 2006 15:15:09 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, a re-reminder:

At some convenient point, I'm going to move libata core and drivers to 
new directory drivers/ata.

The other noticeable change coming down the pipe is iomap support, which 
will kill those annoying warnings you see on every build (in addition to 
shrinking the driver a bit).

Speak up now if there are complaints...

	Jeff



