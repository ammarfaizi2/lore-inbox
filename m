Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUCIRjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbUCIRjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:39:24 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:6650 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262070AbUCIRjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:39:23 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: mru@kth.se (=?CP 1252?q?M=E5ns?= =?CP 1252?q?Rullg=E5rd?=)
Subject: Re: GPLv2 or not GPLv2? (no license bashing)
Date: Tue, 9 Mar 2004 11:38:56 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <200403040838.31412.eike-kernel@sf-tec.de> <04030910585602.32521@tabby> <yw1xd67mhqyt.fsf@kth.se>
In-Reply-To: <yw1xd67mhqyt.fsf@kth.se>
MIME-Version: 1.0
Message-Id: <04030911385603.32521@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 March 2004 11:26, Måns Rullgård wrote:
> Jesse Pollard <jesse@cats-chateau.net> writes:
> > On Tuesday 09 March 2004 03:04, Måns Rullgård wrote:
> >> vda <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> >> > Well, Linux kernel is GPLed. If one adds his/hers code to the kernel
> >> > (s)he is automatically agrees to the terms of GPL.
> >> >
> >> > Because "adds code" is actually incorrect here.  "modifies existing
> >> > GPLed code" is more accurate.
> >>
> >> Suppose I write a new kernel module, without touching any existing
> >> code, and this module gets included in the kernel tree.  Have I added
> >> code?  Yes.  Have I modified GPLed code?  I think not.
> >
> > But you did incorporate GPL interfaces, likely some inline functions...
>
> Suppose for the sake of argument that I didn't.  Besides, simply
> including header files doesn't count.

Then your binary module is good to go... until the next patch or update.
