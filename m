Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVAMBed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVAMBed (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVALVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:21:38 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:51844 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261276AbVALVQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:16:29 -0500
Message-Id: <200501122116.j0CLGK3K022477@localhost.localdomain>
To: Matt Mackall <mpm@selenic.com>
cc: "Jack O'Quin" <joq@io.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Wed, 12 Jan 2005 10:52:58 PST."
             <20050112185258.GG2940@waste.org> 
Date: Wed, 12 Jan 2005 16:16:20 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.152.253.251] at Wed, 12 Jan 2005 15:16:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What I find offensive is you repeatedly telling me I'm naive, when
>I've actually written a proper RT kernel AND run a music production
>company.

But you are being naive Matt! Nobody claims that OSX is hard-RT, or
even that OS9 is hard-RT, but people are able to Get Work Done on
those systems without jumping through hoops or arguing with kernel
developers. This happens because (a) the OS is enough-RT and (b) the
developers in question accepted the requirements of DAW and sequencer
users as totally legitimate.

As I stated before, we already *have* Linux kernels whose performance
in the RT area is at least as good as OSX (thanks to Andrew and Ingo,
primarily), but users cannot access these facilities without doing a
song and dance and a download or two. This is the issue that requires
fixing, from our perspective.

--p

