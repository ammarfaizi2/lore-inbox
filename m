Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbTHLNXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbTHLNXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:23:30 -0400
Received: from ns1.greycloaklabs.ca ([216.232.118.71]:33541 "EHLO
	gateway.greycloaklabs.ca") by vger.kernel.org with ESMTP
	id S270234AbTHLNXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:23:30 -0400
Date: Tue, 12 Aug 2003 06:24:23 -0700 (PDT)
From: Matthew Peters <matthew@greycloaklabs.ca>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: kswapd and toshiba libretto 50ct
In-Reply-To: <200308021713.41569.mflt1@micrologica.com.hk>
Message-ID: <Pine.LNX.4.44.0308120622050.11089-100000@gateway.greycloaklabs.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have managed to resolder that pin, the kernel detects a clock speed of
75mhz again. The 2.4 kernels still don't work though. I've tried using
both a modular build and one with everything tailored to the system.

I don't have the oops message on hand, but i can get it if required. As
always, i can't check it on the hardware itself.

Thanks in advance,
    Matthew


