Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWFHP7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWFHP7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWFHP7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:59:54 -0400
Received: from xenotime.net ([66.160.160.81]:32133 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964890AbWFHP7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:59:53 -0400
Date: Thu, 8 Jun 2006 09:02:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: John Richard Moser <nigelenki@comcast.net>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Clean-up:  TASK_UNMAPPED_BASE and mmap_base
Message-Id: <20060608090239.3da80037.rdunlap@xenotime.net>
In-Reply-To: <448843A4.8070102@comcast.net>
References: <44862CE3.7040406@comcast.net>
	<1149769487.3380.70.camel@laptopd505.fenrus.org>
	<448843A4.8070102@comcast.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2006 11:35:00 -0400 John Richard Moser wrote:

> 
> Arjan van de Ven wrote:
> > On Tue, 2006-06-06 at 21:33 -0400, John Richard Moser wrote:

> > now if you put your patch inline you'd get comments in detail
> > 
> 
> Hmm.  I hit "Attach" in Thunderbird.  Viewing the message shows the
> patch inline with the message for me.  I wasn't aware I needed to do
> something for that.  (Any help here is appreciated.. I'm sure I can't
> just copy-paste the diff because Thunderbird likes to wrap long lines
> PHYSICALLY)

Attachments don't show up in some mail clients.

See
http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
and
http://lkml.org/lkml/2005/12/27/191


---
~Randy
