Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVBSBB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVBSBB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 20:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVBSBB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 20:01:59 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:52677 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261597AbVBSBB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 20:01:57 -0500
Subject: Re: I wrote a kernel tool for monitoring / web page
From: Lee Revell <rlrevell@joe-job.com>
To: sylvanino b <sylvanino@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d14685de050218164127828b06@mail.gmail.com>
References: <d14685de050218164127828b06@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 20:01:55 -0500
Message-Id: <1108774916.6040.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 01:41 +0100, sylvanino b wrote:
> I did a webpage for it, you can check it out at:
> http://membres.lycos.fr/kernelanalyzer/
> 
> If you have any comment/critics, don't hesitate to share it

Is this meant to run on a Windows system or something?  The screenshots
look like Windows, and the archive is a .rar file.

I was not able to extract the .rar file.  File roller does not work at
all because it tries to pass the nonexistent "-c" switch to unrar.  And
it won't unrar manually:

rlrevell@mindpipe:~/cvs$ unrar kernelanalyzer.rar 2>&1 | head -20

unrar 0.0.1           Copyright (c) 2004 Ben Asselstine


Extracting from /smb/rlrevell/cvs/kernelanalyzer.rar

Extracting  download/image/ex1.JPG                                    Failed    
Extracting  download/image/ex2.JPG                                    Failed    
Extracting  download/image/schema.PNG                                 Failed

Please use standard Linux file formats like .tar.gz instead of oddballs like .rar.

Lee

