Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268539AbUILQ1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268539AbUILQ1o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268708AbUILQ1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:27:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11701 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268539AbUILQ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:27:42 -0400
Subject: Re: The Serial Layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Eger <eger@havoc.gtf.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040912030150.GA22858@havoc.gtf.org>
References: <1094582980.9750.12.camel@localhost.localdomain>
	 <20040912030150.GA22858@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095002727.11737.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 16:25:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 04:01, David Eger wrote:
> While you're at it, could you patch it up so we can have more than one
> serial device again?  I tracked down a bug a month ago having to do
> with the pmac_zilog driver freaking out because it tried to 

uart layer is rather below the stuff I'm touching in the tty code.
