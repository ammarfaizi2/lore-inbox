Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTJIVs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbTJIVs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:48:58 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:62310 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id S262601AbTJIVsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:48:50 -0400
Date: Fri, 10 Oct 2003 07:50:29 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: "Bill J.Xu" <xujz@neusoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: a kernel panic question
In-Reply-To: <00bc01c38e02$1fb4d790$2a02010a@avwindows>
Message-ID: <Pine.LNX.4.05.10310100739280.18751-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Bill J.Xu wrote:

> SORRY,forget to write title!
> 
> Hi all,
> 
> I build a firewall based on linux 2.2.19,and now when I connect the firewall to the network,system will die with the following message.
> 
> Fw:~# Kernel panic: skput:under: c00bc7d8:86 put:26 dev:eth1
> In swapper task - not syncing
> Rebooting in 180 seconds..

1) What hardware is your eth1 (snippage from lspci might be helpful)?

2) Any chance of upgrading to at least a relatively recent 2.2 kernel
(e.g. 2.2.25 is the latest) and seeing if the problem persists?

3) If per chance you can reproduce the problem with current 2.2, you're
going to have to tell us more info.  E.g. see: linux/REPORTING-BUGS or
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

HTH,
Neale.

