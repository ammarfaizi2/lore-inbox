Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWA2Hhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWA2Hhg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWA2Hhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:37:36 -0500
Received: from tachyon.quantumlinux.com ([64.113.1.99]:24508 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S1751164AbWA2Hfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:35:47 -0500
Date: Sat, 28 Jan 2006 23:36:25 -0800 (PST)
From: Chuck Wolber <chuckw@quantumlinux.com>
X-X-Sender: chuckw@localhost.localdomain
To: Willy Tarreau <willy@w.ods.org>
cc: Greg KH <gregkh@suse.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       jmforbes@linuxtx.org, linux-kernel@vger.kernel.org, stable@kernel.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, davej@redhat.com,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
In-Reply-To: <20060129060946.GX7142@w.ods.org>
Message-ID: <Pine.LNX.4.63.0601282326250.7205@localhost.localdomain>
References: <20060128021749.GA10362@kroah.com> <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
 <20060129044307.GA23553@linuxtx.org> <Pine.LNX.4.63.0601282048380.7205@localhost.localdomain>
 <20060128205701.5b84922e.rdunlap@xenotime.net> <20060129053458.GA9293@suse.de>
 <20060129060946.GX7142@w.ods.org>
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

On Sun, 29 Jan 2006, Willy Tarreau wrote:

> Greg, there will always be stupid people who don't understand the work 
> of others.

Hmmm, true, but I wouldn't call them stupid, just a bit ignorant. It's 
incumbent upon us to manage and maintain expectations to fix that problem.


> I'm very glad that you take care of people who cannot easily upgrade to 
> latest version, and I'm sure that a lot of users are too.

Me too. I'd never dream of criticizing Greg's efforts. He's done an 
incredible job. I think better defining -stable will make life easier for 
him and help us be more productive.

..Chuck..


-- 
http://www.quantumlinux.com
 Quantum Linux Laboratories, LLC.
 ACCELERATING Business with Open Technology

 "The measure of the restoration lies in the extent to which we apply
  social values more noble than mere monetary profit." - FDR
