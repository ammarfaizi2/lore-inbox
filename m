Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbULKKGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbULKKGN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 05:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbULKKGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 05:06:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35508 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261926AbULKKGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 05:06:11 -0500
Message-ID: <41BAC68D.6050303@pobox.com>
Date: Sat, 11 Dec 2004 05:06:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rudi@asics.ws
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel (64bit) 4GB memory support
References: <1102752990.17081.160.camel@cpu0>
In-Reply-To: <1102752990.17081.160.camel@cpu0>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Usselmann wrote:
> Could anybody tell me which of the previous (non 2.6.9) kernels
> do support 4GB of main memory in 64 bit mode ?

64bit kernels have supported >4GB since their ports inception, AFAIK.

Your platform could limit this artificially, of course.

	Jeff



