Return-Path: <linux-kernel-owner+w=401wt.eu-S1751786AbXAQVzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbXAQVzk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbXAQVzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:55:39 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56001 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbXAQVzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:55:37 -0500
Message-ID: <45AE9B4F.6030003@zytor.com>
Date: Wed, 17 Jan 2007 13:55:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce two new maturlty levels:  DEPRECATED and OBSOLETE.
References: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   To go along with the EXPERIMENTAL kernel config status, introduce
> two new states:  DEPRECATED and OBSOLETE.

I think this is a very good idea.  If nothing else, it gives some 
middle-of-the-roadness to the continual "to remove or not to remove" debate.

	-hpa
