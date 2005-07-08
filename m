Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVGHGb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVGHGb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVGHGb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:31:28 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:1198 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262633AbVGHGaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:30:00 -0400
Message-ID: <42CE1D62.80800@myrealbox.com>
Date: Thu, 07 Jul 2005 23:29:54 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Kukard <nkukard@lbsd.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs + quotas in kernel 2.6.11.12
References: <42CDA612.6000001@lbsd.net>
In-Reply-To: <42CDA612.6000001@lbsd.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard wrote:
> Hi Guys,
> 
> How stable is reiserfs quotas in 2.6.11.12?

It's been stable for me for months (using various 2.6.11.y kernels), 
over RAID-5 even.

--Andy
