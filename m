Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbVIOEyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbVIOEyh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 00:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVIOEye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 00:54:34 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:24755 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965039AbVIOEyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 00:54:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:Reply-To:To:Subject:Date:User-Agent:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=CU2sHWRsda8HQJ9z9o5nI2hmvVQd5JUEmNDQHqi/4Do/M9PoTXDBALwtb3lTBqnmxangmCSvEujqfGaeCmBLFUpHARXtpaMGwutAmCGUt92POj5kbNAmUqV3fbxBbBBQy8wsIDwp1jkkKWJsbKOagP0dipnbPgxFFKuAW6D7Brs=  ;
From: Marek W <marekw1977@yahoo.com.au>
Reply-To: marekw1977@yahoo.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
Date: Thu, 15 Sep 2005 14:18:13 +1000
User-Agent: KMail/1.8.2
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz> <1126753444.13893.123.camel@mindpipe>
In-Reply-To: <1126753444.13893.123.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509151418.13927.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 13:04, Lee Revell wrote:
> On Wed, 2005-09-14 at 19:03 -0700, David Lang wrote:
> > another advantage of having an auto-config for the kernel is that people
> > who are experimenting may have the auto-config find hardware that they
> > didn't realize they had (or they didn't realize that support had been
> > added)
> >
> > I know that most of my kernels don't have support for everything the
> > motherboards have on them (mostly I don't care much about the other
> > features, but in some cases they weren't supported, or weren't worth the
> > hassle of figureing the correct config for when I started, and I've never
> > gone back to try and figure it out)
>
> Why does this have to be in the kernel again?  Isn't this exactly what
> you get with a fully modular config and hotplug?

Not so much the kernel. When compiling the kernel I'd prefer not to waste time 
and space compiling the 100+ modules I will never ever use on my laptop. I'd 
prefer for something to select the modules necessary for my hardware. I can't 
afford the time to keep up to date with that's new and what isn't, what has 
changed, what has been superseded, which module works with which device, 
chipset even, etc...


-- 
-
Marek W

--
2b | !2b
Send instant messages to your online friends http://au.messenger.yahoo.com 
