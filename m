Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbUDFI0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 04:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUDFI0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 04:26:14 -0400
Received: from stress.telefonica.net ([213.4.129.135]:59254 "EHLO
	tnetsmtp2.mail.isp") by vger.kernel.org with ESMTP id S263659AbUDFI0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 04:26:12 -0400
From: Xan <DXpublica@telefonica.net>
Reply-To: DXpublica@telefonica.net
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [kernel.org] md5 for verifying downloads of kernel [right post]
Date: Tue, 6 Apr 2004 10:26:05 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0404052150570.13902-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0404052150570.13902-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061026.05377.DXpublica@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimarts 06 Abril 2004 03:52, en/na Mark Hahn (<Mark Hahn 
<hahn@physics.mcmaster.ca>>) va escriure:
> > Is it possible to put in webpage and in ftp a link and a file,
> > respectively, of the md5 sums (or any other checking file program) of all
> > kernel files?.
>
> why are you not satisfied with the current GnuPG signatures on
> kernel tars and patch files?
>
> ie
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/linux-2.6.1.tar.gz.sign
>
> > With this, anyone could see if the downloaded kernel file (usually more
> > than 30MB) is well-downloaded.
>
> indeed, tars and patches have been signed for a long time.

Okay. I did not know that. Now I satisfied ;-). But, I think a "miss": the 
webmaster of kernel.org could link the signature of all kernel files (?). 
That is, could we have got something like:

The latest stable version of the Linux kernel is:  	2.6.5 	2004-04-04 04:17 
UTC 	F 	V 	VI 	C 	Changelog SIGN

where SIGN links to 2.6.5 signature?

Sorry, but I think that the reference to signature page in kernel.org is not 
of all visible. It's in a more low possition, I think.

Sorry for ask that,
Xan.
