Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132749AbRDDFQI>; Wed, 4 Apr 2001 01:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132751AbRDDFP6>; Wed, 4 Apr 2001 01:15:58 -0400
Received: from [200.207.75.239] ([200.207.75.239]:8320 "EHLO
	sartre.linuxbr.com") by vger.kernel.org with ESMTP
	id <S132749AbRDDFPl>; Wed, 4 Apr 2001 01:15:41 -0400
Date: Wed, 4 Apr 2001 02:13:49 -0300 (BRT)
From: Jean Paul Sartre <sartre@linuxbr.com>
To: "Manfred H. Winter" <mahowi@gmx.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.3] PPP errors
In-Reply-To: <20010404021554.A1596@marvin.mahowi.de>
Message-ID: <Pine.LNX.4.21.0104040213220.803-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, Manfred H. Winter wrote:

> Apr  4 02:05:21 marvin pppd[1227]: Couldn't set tty to PPP discipline: Invalid a
> rgument
> Apr  4 02:05:21 marvin pppd[1227]: Exit.

	Did you load the 'ppp_async.o' module?

	Regards,
	Cesar Suga <sartre@linuxbr.com>


