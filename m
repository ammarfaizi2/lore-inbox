Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271304AbUJVOnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271304AbUJVOnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271300AbUJVOnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:43:15 -0400
Received: from fisek2.ada.net.tr ([195.112.153.19]:44738 "EHLO
	embriyo.fisek.com.tr") by vger.kernel.org with ESMTP
	id S271304AbUJVOl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:41:58 -0400
Date: Fri, 22 Oct 2004 17:41:54 +0300
From: Onur Kucuk <onur@delipenguen.net>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buggy DSDTs policy ?
Message-Id: <20041022174154.2ebd2c5c.onur@delipenguen.net>
In-Reply-To: <20041022122326.GA69381@dspnet.fr.eu.org>
References: <20041022122326.GA69381@dspnet.fr.eu.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Oct 2004 14:23:27 +0200
Olivier Galibert <galibert@pobox.com> wrote:

> What is the policy w.r.t broken DSDTs and the ACPI subsystem?
> Specifically, which of these two options is right:
> 
> 1- Provide a non-buggy DSDT to the kernel
> 2- Make the ACPI subsystem tolerant of the bugs
> 
> The option 3, have all biosen over the world fixed is a nice fantasy,
> but nothing else.
> 
> If 1, we need to put a mechanism for that in the official kernel.

 CONFIG_ACPI_CUSTOM_DSDT is included in 2.6.9


 
> If 2, I'll start working on patches to make the laptop I play with
> work as-is.
> 
> So, which it is?


-- 
 Onur Kucuk                                        Knowledge speaks,   
 <onur.--.-.delipenguen.net>                       but wisdom listens  

