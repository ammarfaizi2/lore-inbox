Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUCZCaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUCZCaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:30:13 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:65156 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262265AbUCZCaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:30:10 -0500
Message-ID: <406395A9.8020101@matchmail.com>
Date: Thu, 25 Mar 2004 18:30:01 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: timg@tpi.com
CC: linux-kernel@vger.kernel.org
Subject: Re: ARP does not scale
References: <200403131129.51083.timg@tpi.com>
In-Reply-To: <200403131129.51083.timg@tpi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Gardner wrote:
> ARP has hash table and garbage collection scalability limitations.
> 

Is this needed for 2.6 also?
