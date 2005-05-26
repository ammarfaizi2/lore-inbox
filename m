Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVEZFb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVEZFb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 01:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEZFb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 01:31:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:7821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261217AbVEZFbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 01:31:53 -0400
Date: Wed, 25 May 2005 22:30:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 2.6.12-rc2*: CD recorder problem
Message-Id: <20050525223057.051c5572.akpm@osdl.org>
In-Reply-To: <200504131837.42930.rjw@sisk.pl>
References: <200504131837.42930.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> On the kernels above and including 2.6.12-rc2 k3b is unable to operate my
> IDE CD recorder.  First time (after a fresh reboot) I start it, it detects the
> recorder properly, but then it refuses to work (it says the media is unknown).
> After k3b is restarted, it can't even detect the drive.
> 
> The problem does not occur on 2.6.11.  I don't know whether it happens for the
> kernels between 2.6.11 and 2.6.12-rc2, but I can check if that's necessary.
> 

Is this still happening in 2.6.12-rc5?
