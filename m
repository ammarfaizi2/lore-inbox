Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbULUNzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbULUNzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbULUNzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:55:05 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:29899 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261759AbULUNy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:54:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ehtTMobTcIHjAPkNXUm6v2rWdvucTOvYxiaEbS/1HetTN7PTCSJZf+qyaa1gxp9nttPX0AVuVeM0laS/2dR1Hfb1xvnWGLOtwjOi6b6N87aCEx+fiRFXcl/BZkwXygf3yUPj+X168QLJjh8lZNDz6OV3Ieq8Z4OJFs75haiOuWM=
Message-ID: <72c6e3790412210554400907c8@mail.gmail.com>
Date: Tue, 21 Dec 2004 19:24:58 +0530
From: linux lover <linux.lover2004@gmail.com>
Reply-To: linux lover <linux.lover2004@gmail.com>
To: Adrian von Bidder <avbidder@fortytwo.ch>
Subject: Re: how to solve kernel oops message
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <200412211415.22276@fortytwo.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <72c6e37904122101137698b6a1@mail.gmail.com>
	 <200412211415.22276@fortytwo.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,
               I have RH9 with its default kernel 2.4.20-8. And i
compile a new kernel 2.4.24 with minimum options in make menuconfig on
2 pcs connected via crossover wire. When i boot both pcs either one
starting first got oops when other pc try to bring eth0 up. What is
the problem?
              I add a lot printk's in kernel to check packet path in
case of TCP connection.
regards,
linux.lover

On Tue, 21 Dec 2004 14:15:17 +0100, Adrian von Bidder
<avbidder@fortytwo.ch> wrote:
> On Tuesday 21 December 2004 10.13, linux lover wrote:
> > Hi all,
> >             I need urgent help on kernel oops message. Can anybody
> [..]
> 
> This information is next to useless. At least report
>  - what did you do that caused the oops message?
>  - what kernel version, exactly, are you using
>    - can you reproduce it with other (newer) kernel versions, too?
>    - can you reproduce it on other machines, too?
>  - how does your kernel configuration look like?
> 
> (btw, your previous message about loading a module makes me wonder if you
> understand enough of Linux to understand what people here might propose
> that you do to solve the problem.  There are are many places where people
> who are new to Linux can request help, but the kernel mailing list is
> probably not one of those...)
> 
> greetings
> -- vbi
> 
> --
> Beware of the FUD - know your enemies. This week
>     * The Alexis de Toqueville Institue *
> http://fortytwo.ch/opinion/adti
> 
> 
>
