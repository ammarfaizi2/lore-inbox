Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRJWMhv>; Tue, 23 Oct 2001 08:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279409AbRJWMhl>; Tue, 23 Oct 2001 08:37:41 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:30984 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S279407AbRJWMh1>; Tue, 23 Oct 2001 08:37:27 -0400
Date: Tue, 23 Oct 2001 07:37:47 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110231237.HAA16435@tomcat.admin.navo.hpc.mil>
To: drevil@warpcore.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Mon, Oct 22, 2001 at 09:24:11PM +0100, Alan Cox wrote:
> > Only Nvidia can help you 
> 
> With a problem caused by someone else and not them? Interesting viewpoint. I
> also find it interesting that people think NVidia is the sole company in control
> of whether or not ther drivers are opened considering SGI and other 3rd parties
> own code in the 'driver pie'. This is a simplistic naive view IMHO....
> -

Not really. Driver writers have always had to provide updates if/when other
parts of the kernel evolved. Especially if they inadvertently depended on
a bug in that other part.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
