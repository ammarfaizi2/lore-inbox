Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUAFGeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266077AbUAFGeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:34:04 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:16281 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266076AbUAFGeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:34:02 -0500
Message-ID: <3FFA56D6.6040808@cyberone.com.au>
Date: Tue, 06 Jan 2004 17:33:58 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.1-rc1-tiny2
References: <20040106054859.GA18208@waste.org>
In-Reply-To: <20040106054859.GA18208@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matt Mackall wrote:

>This is the fourth release of the -tiny kernel tree. The aim of this
>tree is to collect patches that reduce kernel disk and memory
>footprint as well as tools for working on small systems. Target users
>are things like embedded systems, small or legacy desktop folks, and
>handhelds.
>

Have you considered Adrian Bunk's CPU selection rationalisation work?
The last argument I heard against it was that there is lower hanging
fruit for size reduction. You seem to have got a lot of that.

Nick




