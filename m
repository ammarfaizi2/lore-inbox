Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUCVPlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUCVPlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:41:23 -0500
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:37130 "EHLO
	pc16.dolda2000.com") by vger.kernel.org with ESMTP id S262053AbUCVPlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:41:16 -0500
Message-ID: <405F0924.8010304@dolda2000.com>
Date: Mon, 22 Mar 2004 10:41:24 -0500
From: Bruce Park <bpark@dolda2000.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI Shutdown 2.6.3
References: <405DADAC.9010601@dolda2000.com> <20040321190617.GA5650@quadpro.stupendous.org>
In-Reply-To: <20040321190617.GA5650@quadpro.stupendous.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurjen Oskam wrote:

> On Sun, Mar 21, 2004 at 09:58:52AM -0500, Bruce Park wrote:
> 
> 
>>I'm experiencing a problem with ACPI and it's ability to shutdown the 
>>machine. I'm currently using Debian GNU/Linux with the 2.6.3 kernel. Before 
> 
> 
> If you boot with the "nolapic" option, does the machine poweroff correctly
> then?
> 
> (This is the case on my Thinkpad T41 - 2.6.x doesn't powerdown unless I
> boot with "nolapic")
> 

I tried this last night. No success.

bp


