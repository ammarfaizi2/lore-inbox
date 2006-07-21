Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWGUOay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWGUOay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 10:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWGUOay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 10:30:54 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:21922 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750740AbWGUOay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 10:30:54 -0400
Date: Fri, 21 Jul 2006 16:23:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ricknu-0@student.ltu.se
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
In-Reply-To: <1153445087.44c02cdf40511@portal.student.luth.se>
Message-ID: <Pine.LNX.4.61.0607211623270.28469@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <1153445087.44c02cdf40511@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The changes are:
>* u2 has been corrected to u1 (and also added it as __u1)

Do we really need this? Is not 'bool' enough?


Jan Engelhardt
-- 
