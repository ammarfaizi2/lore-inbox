Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVFKSQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVFKSQs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVFKSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:16:48 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:3082 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261770AbVFKSQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:16:46 -0400
Date: Sat, 11 Jun 2005 20:17:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Ilan S." <ilan_sk@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'hello world' module
Message-ID: <20050611181753.GA17310@mars.ravnborg.org>
References: <200506111511.02581.ilan_sk@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506111511.02581.ilan_sk@netvision.net.il>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 03:11:02PM +0300, Ilan S. wrote:
> Hello dear professionals!
> 
> I would be very thankful if anybody prompt me what's wrong.
> I'm trying to build the "Hello world" module from O'Reilly's "Linux device 
> drivers" and that is what I get:
> 
> [ilanso@Netvision Kernel]$ make -C /home/ilanso/src/linux-2.6.11.11 M=`pwd`
> make: Entering directory `/home/ilanso/src/linux-2.6.11.11'
>   Building modules, stage 2.
>   MODPOST
> make: Leaving directory `/home/ilanso/src/linux-2.6.11.11'
> [ilanso@Netvision Kernel]$ ls
> hello.c  Makefile
> [ilanso@Netvision Kernel]$  

Can you please post your Makefile - seems something is wrong here.
You could also try to post the output with the V=1 flagg added when
invoking make.

	Sam
