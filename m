Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTEIU6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 16:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTEIU6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 16:58:45 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:41019 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263448AbTEIU6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 16:58:44 -0400
Date: Fri, 9 May 2003 14:07:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org, randy.dunlap@verizon.net
Subject: Re: 2.5.69 Interrupt Latency
Message-Id: <20030509140727.77d697cc.akpm@digeo.com>
In-Reply-To: <1052503920.2093.5.camel@diemos>
References: <1052323940.2360.7.camel@diemos>
	<1052336482.2020.8.camel@diemos>
	<20030507152856.2a71601d.akpm@digeo.com>
	<1052402187.1995.13.camel@diemos>
	<20030508122205.7b4b8a02.akpm@digeo.com>
	<1052503920.2093.5.camel@diemos>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2003 21:11:18.0495 (UTC) FILETIME=[8891E6F0:01C3166F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> On Thu, 2003-05-08 at 14:22, Andrew Morton wrote:
> > Can you pinpoint a kernel version at which it started to happen?
> 
> I have now isolated the latency problems further to 2.5.68-bk11
> 
> 2.5.68-bk10 an earlier works fine.

Well I'm darned if I can see a thing wrong there.  Are you using
ieee1394, or USB, or any fancy networking features?
