Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVBSBdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVBSBdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 20:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVBSBdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 20:33:06 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:13347 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261605AbVBSBdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 20:33:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Kt/8RnfcLv2Yxlbf0EjufoAInUR0D/xxRKetagkIMiyVSPi5Lagy/bDPPtgSIkzBzjOcVYYz01ZD9b7FPVlxQ0l2k2K/ky4iNw3TCngK1GmRzadmQCbAOZluX/De1m5T8ak8rfXW99o1jtIu7zwkprA7F/Vz0Gy/upNl1I0wXD0=
Message-ID: <d14685de05021817333c563cc9@mail.gmail.com>
Date: Sat, 19 Feb 2005 02:33:00 +0100
From: sylvanino b <sylvanino@gmail.com>
Reply-To: sylvanino b <sylvanino@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: I wrote a kernel tool for monitoring / web page
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1108774916.6040.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <d14685de050218164127828b06@mail.gmail.com>
	 <1108774916.6040.4.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, it's meant to run on linux.
Actually, patch provided is for linux 2.6.9 + kdb 4.4


I have uploaded a new tarball and updated the webpage.
should be ok,

Sylvain
 

On Fri, 18 Feb 2005 20:01:55 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sat, 2005-02-19 at 01:41 +0100, sylvanino b wrote:
> > I did a webpage for it, you can check it out at:
> > http://membres.lycos.fr/kernelanalyzer/
> >
> > If you have any comment/critics, don't hesitate to share it
> 
> Is this meant to run on a Windows system or something?  The screenshots
> look like Windows, and the archive is a .rar file.
> 
> I was not able to extract the .rar file.  File roller does not work at
> all because it tries to pass the nonexistent "-c" switch to unrar.  And
> it won't unrar manually:
> 
> rlrevell@mindpipe:~/cvs$ unrar kernelanalyzer.rar 2>&1 | head -20
> 
> unrar 0.0.1           Copyright (c) 2004 Ben Asselstine
> 
> Extracting from /smb/rlrevell/cvs/kernelanalyzer.rar
> 
> Extracting  download/image/ex1.JPG                                    Failed
> Extracting  download/image/ex2.JPG                                    Failed
> Extracting  download/image/schema.PNG                                 Failed
> 
> Please use standard Linux file formats like .tar.gz instead of oddballs like .rar.
> 
> Lee
> 
>
