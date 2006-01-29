Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWA2EaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWA2EaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 23:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWA2EaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 23:30:15 -0500
Received: from tachyon.quantumlinux.com ([64.113.1.99]:49589 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S1750819AbWA2EaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 23:30:13 -0500
Date: Sat, 28 Jan 2006 20:30:25 -0800 (PST)
From: Chuck Wolber <chuckw@quantumlinux.com>
X-X-Sender: chuckw@localhost.localdomain
To: Greg KH <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
In-Reply-To: <20060128021749.GA10362@kroah.com>
Message-ID: <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
References: <20060128021749.GA10362@kroah.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006, Greg KH wrote:

> This is the start of the stable review cycle for the 2.6.14.7 release. 
> There are 6 patches in this series, all will be posted as a response to 
> this one.  If anyone has any issues with these being applied, please let 
> us know.  If anyone is a maintainer of the proper subsystem, and wants 
> to add a signed-off-by: line to the patch, please respond with it.

Please correct me if I'm wrong here, but aren't we supposed to stop doing 
this for the 2.6.14 release now that 2.6.15 is out?

..Chuck..


-- 
http://www.quantumlinux.com
 Quantum Linux Laboratories, LLC.
 ACCELERATING Business with Open Technology

 "The measure of the restoration lies in the extent to which we apply
  social values more noble than mere monetary profit." - FDR
