Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSF0Svj>; Thu, 27 Jun 2002 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSF0Svi>; Thu, 27 Jun 2002 14:51:38 -0400
Received: from mail.webmaster.com ([216.152.64.131]:47826 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S316910AbSF0Svh> convert rfc822-to-8bit; Thu, 27 Jun 2002 14:51:37 -0400
From: David Schwartz <davids@webmaster.com>
To: <Oliver.Neukum@lrz.uni-muenchen.de>
CC: <Gregoryg@ParadigmGeo.com>, Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 27 Jun 2002 11:53:54 -0700
In-Reply-To: <Pine.SOL.4.44.0206271420530.4631-100000@sun4.lrz-muenchen.de>
Subject: Re: Multiple profiles
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020627185355.AAA28049@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jun 2002 14:22:07 +0200 (MET DST), 
Oliver.Neukum@lrz.uni-muenchen.de wrote:

>On Thu, 27 Jun 2002, David Schwartz wrote:
>
>>    There is no way to create multiple profiles on Linux. But there may be 
>>a
>>way

>Actually there is. We call them runlevels. init seems to be pretty
>standard on Linux systems.

	True, though runlevels don't allow you to change the kernel you're using, 
its command line, or the initrd. In addition, many distributions' preferred 
means of creating profiles is not by means of runlevels.

	DS


