Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWJLWEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWJLWEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWJLWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:04:40 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:37766 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751156AbWJLWEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:04:39 -0400
Date: Fri, 13 Oct 2006 00:02:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: =?ISO-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace process may be able to DoS kernel
In-Reply-To: <1160669968.24931.38.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0610130002250.21560@yvahk01.tjqt.qr>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com> 
 <1160668565.24931.33.camel@mindpipe>  <Pine.LNX.4.61.0610121810050.28908@yvahk01.tjqt.qr>
 <1160669968.24931.38.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >IIRC Ubuntu is the only major distro that ships with CONFIG_PREEMPT=y.
>> >Any difference if you disable it?
>> 
>> SUSE uses CONFIG_PREEMPT(?) Voluntary Preemption too.
>
>CONFIG_PREEMPT_VOLUNTARY != CONFIG_PREEMPT

But modinfo (vermagic) prints PREEMPT at least the former case too, 
which is a little bit misleading.


	-`J'
-- 
