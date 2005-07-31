Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263008AbVGaBX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbVGaBX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 21:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbVGaBX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 21:23:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37079 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263008AbVGaBX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 21:23:58 -0400
Message-ID: <42EC2829.2080108@pobox.com>
Date: Sat, 30 Jul 2005 21:23:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yaroslav Halchenko <kernel@onerussian.com>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 -> 2.6.11 (+ata-dev patch) -- HDD is always on
References: <20050729041031.GU16285@washoe.onerussian.com> <42E9AFC6.9010805@pobox.com> <20050731001138.GG16285@washoe.onerussian.com>
In-Reply-To: <20050731001138.GG16285@washoe.onerussian.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Halchenko wrote:
> On Fri, Jul 29, 2005 at 12:25:42AM -0400, Jeff Garzik wrote:
> 
>>Does this happen in unpatched 2.6.12.3 or 2.6.13-rc4?
> 
> now tested both of them -- light is constantly on in both.
> 
> does the HDD LED always signals about hardware activity or it can just
> be sticky and not reset properly?

As long as the system otherwise functions properly, the LED is the least 
of our worries...

	Jeff



