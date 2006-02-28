Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWB1TT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWB1TT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWB1TT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:19:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60119 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932441AbWB1TTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:19:25 -0500
Date: Tue, 28 Feb 2006 20:19:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: tim tim <tictactoe.tim@gmail.com>
cc: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: packet-data
In-Reply-To: <503e0f9d0602272023x4628208cv5d9845b79ed90ae5@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602282019120.15391@yvahk01.tjqt.qr>
References: <503e0f9d0602272023x4628208cv5d9845b79ed90ae5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>hello.. i know how to capture a packet using netfilter hook.. i even
>succeeded in getting the source and destination adderss of the
>captured packet. but i was unable to retrive data from the packet .. 
>i came to know that there are pointers to access it . but can anybody
>plz show me an example to access data.. thanks in advance.

look at ipt_XOR, for a simple example.


Jan Engelhardt
-- 
