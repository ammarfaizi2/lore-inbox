Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbULFDyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbULFDyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 22:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbULFDyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 22:54:05 -0500
Received: from 209-128-68-124.bayarea.net ([209.128.68.124]:24996 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261467AbULFDyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 22:54:02 -0500
Message-ID: <41B3D79F.9070602@zytor.com>
Date: Sun, 05 Dec 2004 19:53:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
Subject: Re: [2.6 patch] i386/x86_64 msr.c: make two functions static
References: <20041206004135.GK2953@stusta.de>
In-Reply-To: <20041206004135.GK2953@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The patch below makes two needlessly global functions static.
> 
> 
> diffstat output:
>  arch/i386/kernel/msr.c   |    4 ++--
>  arch/x86_64/kernel/msr.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

Looks good to me.
