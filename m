Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUF1O7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUF1O7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUF1O6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:58:54 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:38868 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265000AbUF1O4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:56:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Jun 2004 07:56:03 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Steve G <linux_4ever@yahoo.com>
cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x signal handler bug
In-Reply-To: <20040628112614.98407.qmail@web50609.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0406280754220.18422@bigblue.dev.mdolabs.com>
References: <20040628112614.98407.qmail@web50609.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Steve G wrote:

> >> I think so. Maybe the attached patch?
> 
> >No, the SIG_IGN check should be there ...
> 
> OK. I tested the patch and now the test program runs as it did under 2.4.

Good. I'll toss it to Andrew's back to see if it sticks :)



- Davide

