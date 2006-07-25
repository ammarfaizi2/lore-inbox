Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWGYT5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWGYT5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWGYT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:57:10 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:63449 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932301AbWGYT5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:57:09 -0400
Date: Tue, 25 Jul 2006 21:56:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Damien Pacaud <05087635@brookes.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Odd values in /proc
In-Reply-To: <008301c6af35$14f9f1d0$0100a8c0@serty1>
Message-ID: <Pine.LNX.4.61.0607252155560.12906@yvahk01.tjqt.qr>
References: <20060721211341.5366.93270.sendpatchset@pipe>
 <200607212209.05254.dtor@insightbb.com> <20060724151159.GA5082@fooishbar.org>
 <008301c6af35$14f9f1d0$0100a8c0@serty1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi all,
> I was recently fooling with /proc for a school project and found out
> that ps and top are not doing the same calculation about memory load.

Take a third one and compare:  pmap `pidof X`
(and preferably post that)



Jan Engelhardt
-- 
