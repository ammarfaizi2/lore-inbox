Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUCIQ7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUCIQ7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:59:22 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:3066 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261905AbUCIQ7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:59:20 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: mru@kth.se (=?CP 1252?q?M=E5ns?= =?CP 1252?q?Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: GPLv2 or not GPLv2? (no license bashing)
Date: Tue, 9 Mar 2004 10:58:56 -0600
X-Mailer: KMail [version 1.2]
References: <200403040838.31412.eike-kernel@sf-tec.de> <200403090916.08626.vda@port.imtp.ilyichevsk.odessa.ua> <yw1xhdwy8k8c.fsf@kth.se>
In-Reply-To: <yw1xhdwy8k8c.fsf@kth.se>
MIME-Version: 1.0
Message-Id: <04030910585602.32521@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 March 2004 03:04, Måns Rullgård wrote:
> vda <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> > Well, Linux kernel is GPLed. If one adds his/hers code to the kernel
> > (s)he is automatically agrees to the terms of GPL.
> >
> > Because "adds code" is actually incorrect here.  "modifies existing
> > GPLed code" is more accurate.
>
> Suppose I write a new kernel module, without touching any existing
> code, and this module gets included in the kernel tree.  Have I added
> code?  Yes.  Have I modified GPLed code?  I think not.

But you did incorporate GPL interfaces, likely some inline functions...
