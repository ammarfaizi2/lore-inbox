Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272882AbVBESzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272882AbVBESzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbVBESzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:55:25 -0500
Received: from lucidpixels.com ([66.45.37.187]:15791 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S272882AbVBESw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:52:28 -0500
Date: Sat, 5 Feb 2005 13:52:26 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Simple question regarding loop devices.
In-Reply-To: <42050A39.4040307@osdl.org>
Message-ID: <Pine.LNX.4.62.0502051352140.13241@p500>
References: <Pine.LNX.4.62.0502051233410.13241@p500> <42050A39.4040307@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, very nice, thanks!

On Sat, 5 Feb 2005, Randy.Dunlap wrote:

> Justin Piszcz wrote:
>> Why are there only 7-8 loop devices available?
>> What options do I have if I want to mount, say, 100 isos?
>
> Documentation/kernel-parameters.txt say:
>
> max_loop=       [LOOP] Maximum number of loopback devices that can
> 		be mounted
> 		Format: <1-256>
>
> -- 
> ~Randy
>
