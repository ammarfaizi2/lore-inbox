Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWILJf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWILJf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWILJf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:35:56 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:52657 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965163AbWILJfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:35:55 -0400
Date: Tue, 12 Sep 2006 11:33:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ian Kent <raven@themaw.net>
cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] linux/magic.h for magic numbers
In-Reply-To: <Pine.LNX.4.64.0609121620550.4911@raven.themaw.net>
Message-ID: <Pine.LNX.4.61.0609121130390.16083@yvahk01.tjqt.qr>
References: <20060909110245.GA9617@havoc.gtf.org>
 <Pine.LNX.4.64.0609121620550.4911@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> +#define NCP_SUPER_MAGIC	0x564c		/* Guess, what 0x564c is :-) */

*yawn* Maps to (char[]){"V", "L"}, the author.


Jan Engelhardt
-- 
