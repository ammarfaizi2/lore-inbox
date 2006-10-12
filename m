Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWJLQLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWJLQLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWJLQLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:11:31 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:1498 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932649AbWJLQL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:11:29 -0400
Date: Thu, 12 Oct 2006 18:10:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: =?ISO-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace process may be able to DoS kernel
In-Reply-To: <1160668565.24931.33.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0610121810050.28908@yvahk01.tjqt.qr>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
 <1160668565.24931.33.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> As most users who reported this problem are using Ubuntu,
>> the problem may be related to one of the settings in Ubuntu's kernel
>> config. The configuration of my kernel is also based on the Ubuntu
>> kernel config. As I am not using the patched kernel by Ubuntu I hope
>> that the LKML is the right place to report this issue. 
>
>IIRC Ubuntu is the only major distro that ships with CONFIG_PREEMPT=y.
>Any difference if you disable it?

SUSE uses CONFIG_PREEMPT(?) Voluntary Preemption too.


	-`J'
-- 
