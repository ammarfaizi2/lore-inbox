Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWGKD0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWGKD0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWGKD0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:26:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:48604 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965096AbWGKD0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:26:22 -0400
Message-ID: <44B31A54.3030501@zytor.com>
Date: Mon, 10 Jul 2006 20:26:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc1-mm1
References: <200607102302_MC3-1-C4A4-1385@compuserve.com>
In-Reply-To: <200607102302_MC3-1-C4A4-1385@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> On Sun, 9 Jul 2006 02:11:06 -0700, Andrew morton wrote:
> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 
> Warnings(?) during build:
> 
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/ipconfig' given more than once in the same rule.
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/nfsmount' given more than once in the same rule.
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/run-init' given more than once in the same rule.
> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/fstype' given more than once in the same rule.
> 

Already resolved.

	-hpa
