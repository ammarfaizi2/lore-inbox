Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVF1TZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVF1TZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVF1TZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:25:29 -0400
Received: from terminus.zytor.com ([209.128.68.124]:64679 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261238AbVF1TZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:25:08 -0400
Message-ID: <42C1A404.5080504@zytor.com>
Date: Tue, 28 Jun 2005 12:24:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: webmaster@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: www.kernel.org git changelog feature
References: <1684741176.20050628203038@dns.toxicfilms.tv>
In-Reply-To: <1684741176.20050628203038@dns.toxicfilms.tv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:
> Hi,
> 
> how about adding to the kernel list at http://kernel.org
> a link to the git log.
> 
> Currently we have:
> F V VI C Changelog
> 
> How about adding a link to the respestive git logs ?
> 
> F V VI C Changelog GIT
> 
> GIT might be a link to:
>         http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=shortlog
> or
>         http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=log
> 
> Personally I like better view through the changes looking at the git shortlog,
> which is much more readable than files like patch-2.6.12-git10.log
> 
> Well git log is also more readable than the patch-git.log thing.
> 
> Whaddya think?
> 
> Regards,
> Maciej
> 
> 

An abbreviated shortlog is the first thing on the "C" page, and there is 
already a link there to the full one.

	-hpa
