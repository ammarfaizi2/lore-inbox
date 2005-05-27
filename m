Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVE0HF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVE0HF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVE0HF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:05:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:8324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbVE0G7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:59:20 -0400
Date: Thu, 26 May 2005 23:58:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mikael Starvik" <mikael.starvik@axis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Introducing a new sub-architecture
Message-Id: <20050526235823.7aeaf8e7.akpm@osdl.org>
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801B76457@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C66801B76457@exmail1.se.axis.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mikael Starvik" <mikael.starvik@axis.com> wrote:
>
> I'm about to submit a new sub-architecture under arch/cris and I would
> like to get your input on how this is best done. I can see at least
> 3 alternatives:
> 
> 1. All the patches goes to LKML. Lots of boring patches that most 
> people doesn't care about.
> 2. Send drivers to the driver subsystems maintainers for review 
> and then a big .tgz to Andrew.
> 3. Send the .tgz directly to Andrew without reviews from the
> driver guys.
> 
> I leaning towards option 2, comments?

2 sounds good.

