Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVEZUqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVEZUqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEZUnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:43:19 -0400
Received: from mail.toyon.com ([65.160.147.241]:32744 "EHLO mail.toyon.com")
	by vger.kernel.org with ESMTP id S261734AbVEZUke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:40:34 -0400
Message-ID: <022e01c56233$241e5930$1600a8c0@toyon.corp>
From: "Peter J. Stieber" <developer@toyon.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB> <037801c5616a$b1be6600$1600a8c0@toyon.corp> <4295E9F1.6080304@tmr.com>
Subject: Re: Tyan Opteron boards and problems with parallel ports
Date: Thu, 26 May 2005 13:40:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YhLu>>> Don't always blame BIOS, if you like you could
YhLu>>> use LinuxBIOS instead...

PJS>> Just curious, but why isn't this project (LinuxBIOS)
PJS>> mentioned on the Tyan web site, or is it and I
PJS>> just missed it?
PJS>>
PJS>> You do work for Tyan, right?

BD = Bill Davidsen
BD> What has that to do with anything? I doubt that suggestions
BD> about boot options are on the website or come from the
BD> Tyan website, either.
BD>
BD> Note: I'm not endorsing LinuxBIOS for Opteron, I haven't
BD> personally tried it. But the value of the suggestion depends
BD> on how it works, not who makes it. There appear to be a
BD> lot of reports of problems with Opteron lately, if the BIOS
BD> isn't buggy then the documentation may have lost in
BD> translation.

I have been having the "memory.c bad pmds" with a Tyan S2885 
motherboard.

https://www.redhat.com/archives/fedora-list/2005-May/msg01690.html
http://www.lib.uaa.alaska.edu/linux-kernel/archive/2005-Week-19/1397.html

When Yhlu brought up the topic of LinuxBIOS, I thought he might be 
suggesting that this would prove there are no problems with the BIOS 
(i.e. the same problems would occur with LinuxBIOS as with the 
motherboards built-in BIOS). Looking at the LinuxBIOS web site, I got 
the impression (I may be wrong) that this was a Tyan supported effort. 
If that was the case I was wondering why Tyan didn't mention LinuxBIOS 
on their web site. It would make me more comfortable if this were a Tyan 
supported effort. That's why I asked the question.

I'm just trying anything I can to get rid of the bad pmd messages.

Pete 


