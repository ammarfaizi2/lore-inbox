Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUCBSng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCBSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:43:18 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:26765 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261735AbUCBSkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:40:31 -0500
Message-ID: <4044D513.5090607@matchmail.com>
Date: Tue, 02 Mar 2004 10:40:19 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: albhaf <albhaf@home.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Better performance with 2.6
References: <1078229894.53b994c0albhaf@home.se>
In-Reply-To: <1078229894.53b994c0albhaf@home.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

albhaf wrote:
> I know that 2.6 has the ability to get better
> performance than the other versions.
> But what parts of the kernel has provided to this
> performance upgrade?

Preempt
BIO
Enhanced Locking

There are others I can't think of now, but these are definately high on 
the list.

Mike
