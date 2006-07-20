Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWGTKrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWGTKrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 06:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWGTKrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 06:47:20 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:27534 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030264AbWGTKrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 06:47:19 -0400
Date: Thu, 20 Jul 2006 12:46:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Torsten Landschoff <torsten@debian.org>
cc: Mattias Hedenskog <ml@magog.se>, linux-kernel@vger.kernel.org
Subject: Re: XFS breakage in 2.6.18-rc1
In-Reply-To: <20060719210913.GA1072@stargate.galaxy>
Message-ID: <Pine.LNX.4.61.0607201245340.2633@yvahk01.tjqt.qr>
References: <67dc30140607190717r57ed2fe5w719dcca896110d8@mail.gmail.com>
 <20060719210913.GA1072@stargate.galaxy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>> reproducible in 2.6.17 and 2.6.18-rc1 as well. When I tried to repair
>> the fs I got the same error as in the previous post, running xfsprogs
>> 2.8.4. I haven't had the time to debug this issue further because the
>> box is quite critical but I'll keep an eye on the other disks on the
>> system still running xfs.

I think my experience is worth too: The (that is, of one box) xfs 
filesystem was created IIRC under 2.6.16, and survived throughout 2.6.17 
and 2.6.18-rc1 so far...


Jan Engelhardt
-- 
