Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVAGP2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVAGP2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVAGP2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:28:40 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:36022 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261461AbVAGP1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:27:35 -0500
Message-Id: <200501071527.j07FRXrD018499@localhost.localdomain>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 15:42:23 +0100."
             <20050107144223.GA28466@devserv.devel.redhat.com> 
Date: Fri, 07 Jan 2005 10:27:33 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 09:27:34 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>now try 2.6.9 ;)
>this deficiency got already fixed

well thats good, i hope someone updated the man page too :) 

but is there actually any way to grant specific users a reasonable
rlimit, or are you proposing that we adopt another "bad idea" from OS
X and let everybody do this?

--p

