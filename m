Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWJMNiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWJMNiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJMNiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:38:46 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:220 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750780AbWJMNiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:38:46 -0400
Date: Fri, 13 Oct 2006 15:38:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: art@usfltd.com
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3cow - file system question ?
In-Reply-To: <20061012151826.qf6ftpeowthwsogk@69.222.0.225>
Message-ID: <Pine.LNX.4.61.0610131535130.18631@yvahk01.tjqt.qr>
References: <20061012151826.qf6ftpeowthwsogk@69.222.0.225>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> ext3cow - file system question ?

I don't know whether that constitutes a question.

> - 2.6.x -compatibility ?

No.

However, you may try unionfs which also can do what one could call
snapshotting.


	-`J'
-- 
