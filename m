Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUCIH0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 02:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCIH0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 02:26:15 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:18445 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261531AbUCIH0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 02:26:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: GPLv2 or not GPLv2? (no license bashing)
Date: Tue, 9 Mar 2004 09:16:08 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200403040838.31412.eike-kernel@sf-tec.de> <Pine.LNX.4.53.0403040848530.17622@chaos>
In-Reply-To: <Pine.LNX.4.53.0403040848530.17622@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403090916.08626.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 March 2004 16:11, Richard B. Johnson wrote:
> On Thu, 4 Mar 2004, Rolf Eike Beer wrote:
> > Hi all,
> >
> > just digging a bit in the kernel and found some funny things:
> >
> > -there is a tag only for "GPL v2" but there are some drivers claiming to
> > be v2 and not using this (patch will follow)
> > -there are some drivers with the comment ", either version 2 of the
> > License." in the header. s/either // ? If so, there are some more files
> > where someone should change MODULE_LICENSE("GPL") to "GPL v2".
>
> I don't think anybody, but the original author, can change the
> licensing or its symbology. In other words, if there is a
> MODULE_LICENSE("ZORK"), that stays until it is changed by
> the author that inserted it initially.
>
> In fact, a review of Linux history by a first-year law student
> may show that somebody, not the original author, added the
> MODULE_LICENSE() macro to a lot of modules that didn't have
> any such macro, and thereby assigned some license that did
> not previously exist! Such an implied license may not be valid
> because the original author of the work did not perform that
> assignment.
>
> I think you need to be vigilant and not fall into the RMS trap
> where anything that is "found" anywhere, automatically becomes
> the property of GPL.

Well, Linux kernel is GPLed. If one adds his/hers code to
the kernel (s)he is automatically agrees to the terms of GPL.

Because "adds code" is actually incorrect here.
"modifies existing GPLed code" is more accurate.

Or so I see it.
--
vda
