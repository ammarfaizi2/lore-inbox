Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVC0Ux3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVC0Ux3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVC0Uv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:51:28 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:17163 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261587AbVC0Uuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:50:55 -0500
Message-ID: <42471CA9.1080400@superbug.co.uk>
Date: Sun, 27 Mar 2005 21:50:49 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fortescue wrote:
> Hi,
> 
> I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
> I have found that I can't use SYSFS on Linux-2.6.10.
> 
> Why ?. 
> 
> I am not modifing the Kernel/SYSFS code so I should be able, to use all
> the SYSFS/internal kernel function calls without hinderence.
> 
> In order to be able to use SYSFS to debug the driver during development
> the way I would like to be able to do, I will have to temporally change
> the module licence line to "GPL". When the development is finnished I will
> then need to remove all the code that accesses the SYSFS stuf in the
> Kernel and change the module back to a "Proprietry" licence in order to
> comply with other requirements. This will then hinder any debugging if
> future issues arise.
> 
> I believe that this sort of idiocy is what helps Microsoft hold on to its
> manopoly and as shuch hinders hardware/software development in all areas
> and should be chanaged in a way that promotes diversified software
> development.
> 
> Regards
> 	Mark Fortescue.
> 
> 

If you wish to keep stuff secret, just don't bother with Linux drivers
for it. Use your PCI card in windows or some other system. Linux is
supposed to be open source...live with it.

