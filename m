Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVIODEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVIODEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 23:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVIODEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 23:04:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1417 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030351AbVIODEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 23:04:06 -0400
Subject: Re: Automatic Configuration of a Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Hua Zhong <hzhong@gmail.com>, marekw1977@yahoo.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
	 <6bffcb0e05091415533d563c5a@mail.gmail.com><4328B710.5080503@in.tum.de>
	 <200509151009.59981.marekw1977@yahoo.com.au>
	 <924c288305091417375fea4ec2@mail.gmail.com>
	 <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 23:04:03 -0400
Message-Id: <1126753444.13893.123.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 19:03 -0700, David Lang wrote:
> another advantage of having an auto-config for the kernel is that people 
> who are experimenting may have the auto-config find hardware that they 
> didn't realize they had (or they didn't realize that support had been 
> added)
> 
> I know that most of my kernels don't have support for everything the 
> motherboards have on them (mostly I don't care much about the other 
> features, but in some cases they weren't supported, or weren't worth the 
> hassle of figureing the correct config for when I started, and I've never 
> gone back to try and figure it out)

Why does this have to be in the kernel again?  Isn't this exactly what
you get with a fully modular config and hotplug?

Lee

