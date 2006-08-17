Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWHQJQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWHQJQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWHQJQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:16:50 -0400
Received: from main.gmane.org ([80.91.229.2]:55264 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932377AbWHQJQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:16:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: Linux 2.4.34-pre1
Date: Thu, 17 Aug 2006 12:16:56 +0300
Message-ID: <ec1c5j$5mu$1@sea.gmane.org>
References: <20060817075705.79729.qmail@web52908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e194.netikka.fi
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
In-Reply-To: <20060817075705.79729.qmail@web52908.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Rankin skrev:
>> But maybe it's worth doing a user survey to find out what the users of
>> 2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
>> people who use enterprise distro kernels don't count for this since
>> they'll not go to a newer released 2.4 anyway)
> 
> I have only one machine that is still running a v2.4 kernel (from ftp.kernel.org), and that is an
> old P120 that I occasionally use as a wireless acess point.
> 
> The compiler on this P120 is indeed gcc-3.4. However, building any kernel on that machine is now
> so excruciatingly painful that I am considering using a newer, beefier machine as a build machine
> instead. That machine is running FC5, and so uses gcc-4.1. So from my perspective, being able to
> build a 2.4 kernel using gcc-4.x would be a benefit.
> 
>

Why not simply set up chroots to build in ??

--
Thomas

