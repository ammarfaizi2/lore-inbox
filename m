Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTK0V72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 16:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTK0V71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 16:59:27 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:26053 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261270AbTK0V71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 16:59:27 -0500
From: Duncan Sands <baldrick@free.fr>
To: Vladimir Lazarenko <vlad@lazarenko.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9/10 speedtouch glitch
Date: Thu, 27 Nov 2003 21:43:05 +0100
User-Agent: KMail/1.5.4
References: <200311272023.56413.vlad@lazarenko.net>
In-Reply-To: <200311272023.56413.vlad@lazarenko.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311272143.05662.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dunno if this has been mentioned already, but I have an interesting glitch
> with speedtouch DSL modem. When i compile the driver as module, it says
> registered driver speedtouch, but can not access the device.
>
> However, when i compile the driver in, everything works smoothly and
> nicely. If you need some more testing/information do not hesitate to
> contact me.

Try the latest hotplug scripts.

I hope this helps,

Duncan.
