Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVDDJzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDDJzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDDJzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:55:46 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:5173 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261193AbVDDJzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:55:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bjcKjUzKtIiu+pRa+gCJHSWxE9LHWai+pizkwfN2DV1+2lpmr8GbBdcmfKCuS5yNcn6tdjRh5J2ocV1aDDDFA5moIsHbkJbqsHRzANB1D5LfJGpRe+uiiigBBX1xbqYjtebd9zpPu6NfsZNY6umAppkpcFJmRlWrFmbrEhy0+sc=
Message-ID: <c0310912050404025520a3fd80@mail.gmail.com>
Date: Mon, 4 Apr 2005 18:55:38 +0900
From: Piotr Muszynski <piotru@gmail.com>
Reply-To: Piotr Muszynski <piotru@gmail.com>
To: prasanna@in.ibm.com
Subject: Re: module for controlling kprobes with /proc
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@sgi.com>
In-Reply-To: <20050404083507.GG1715@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050404083507.GG1715@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prasanna,

On Apr 4, 2005 5:35 PM, Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> why /proc ?

Thank you for your remarks. I originally thought of writing a simple
CLI app  to sit over /proc , do basic sanity checks and be simple to
use.

> You can use a combination of SysRq key to enter a kprobe command line prompt.
> Initially you can define a dummy breakpoint for command line prompt and accept
> commands from thereon.
> Later display the list of features add/remove/display breakpoint, backtrace etc.
> Also once you hit a breakpoint you give a command line prompt and user can backtrace/ dump some global memory, dump registers etc.
> 
> Let me know if you need more information.

Yes please, I would be grateful.
TIA

Piotr
