Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVATUXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVATUXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVATUXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:23:50 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:61313 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261503AbVATUXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:23:48 -0500
Subject: Re: IEEE-1394 and disks
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1106250812.3413.10.camel@localhost.localdomain>
References: <1106250812.3413.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 13:23:47 -0700
Message-Id: <1106252627.3413.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By bridge chips I mean IEEE-1394 to IDE. Also, is it possible to set
spin down time for these IDE disks through 1394? i.e. if they are
inactive for 1 hour, I would like them to spin down. Is this possible?

Trever

On Thu, 2005-01-20 at 12:53 -0700, Trever L. Adams wrote:
> I have a few questions: How stable is firewire (running at 800Mbps or
> faster, if any is available yet)? How stable is the Linux subsystem,
> especially for firewire disks? Is there any particularly 800Mbps bridge
> chips that should be avoided or used?
> 
> How stable is the subsystem when the chain is nearly full (62 devices is
> full right?)
> 
> How many controllers may be in the system before the Firewire subsystem
> gets confused?
> 
> Trever Adams
> --
> "There are two ways to live your life. One is as though nothing is a
> miracle. The other is as though everything is a miracle." -- Albert
> Einstein
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
--
"If there was strife and contention in the home, very little else in
life could compensate for it." -- Lawana Blackwell, The Courtship of the
Vicar's Daughter, 1998

