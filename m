Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264225AbTCXOcL>; Mon, 24 Mar 2003 09:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264230AbTCXOcJ>; Mon, 24 Mar 2003 09:32:09 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:28434 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264225AbTCXOcB>; Mon, 24 Mar 2003 09:32:01 -0500
Date: Mon, 24 Mar 2003 15:43:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
In-Reply-To: <20030324142515.GA10462@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0303241540230.5042-100000@serv>
References: <Pine.LNX.4.44.0303240023420.9053-100000@serv>
 <20030324142515.GA10462@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Mar 2003, Andries Brouwer wrote:

> It still looks like you do not understand the purpose of these patches.
> First of all, it is a series - code is morphed into a more desirable
> state; at each point in time there are imperfections, and some of these
> disappear the next stage.

It would help a lot if you would explain what these next stages are.

> The first goal is not at all handling many devices. The first goal is
> having a larger dev_t. Handling many devices comes after that.

My patch already does both. What am I doing wrong?

bye, Roman

