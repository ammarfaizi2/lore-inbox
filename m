Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWGKT0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWGKT0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGKT0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:26:12 -0400
Received: from fmr18.intel.com ([134.134.136.17]:983 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751192AbWGKT0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:26:11 -0400
Date: Tue, 11 Jul 2006 12:26:07 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6: BUG: spinlock wrong CPU on CPU#1,
 kacpid_notify/7105
Message-Id: <20060711122607.a290f3e6.kristen.c.accardi@intel.com>
In-Reply-To: <44B08F3F.1080704@goop.org>
References: <44B08F3F.1080704@goop.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jul 2006 22:08:15 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> [ Repost: got linux-acpi's address wrong. ]
> 
> I just got this while undocking my machine.  Thinkpad X60, Core Duo CPU.
>

Hi Jeremy,
I think the patch I posted on Friday will solve this issue:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115230920629981&w=2

It is included in 2.6.18-rc1-mm1.

Let me know if this works for you.

Kristen
