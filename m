Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVCOBrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVCOBrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVCOBrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:47:33 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:8557 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262197AbVCOBrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:47:31 -0500
Message-ID: <42363EAB.3050603@yahoo.com.au>
Date: Tue, 15 Mar 2005 12:47:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH][1/2] SquashFS
References: <4235BAC0.6020001@lougher.demon.co.uk> <20050315003802.GH3163@waste.org>
In-Reply-To: <20050315003802.GH3163@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>>+	for (;;) {
>>
>
>while (1)
>
>

I always thought for (;;) was preferred. Or at least acceptable?


