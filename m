Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWCJD0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWCJD0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCJD0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:26:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11756 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932176AbWCJD0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:26:03 -0500
Subject: Re: How can I link the kernel with libgcc ?
From: Lee Revell <rlrevell@joe-job.com>
To: Carlos Munoz <carlos@kenati.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <4410F1BE.7000904@kenati.com>
References: <4410D9F0.6010707@kenati.com>
	 <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
	 <1141956362.13319.105.camel@mindpipe> <4410EC0D.3090303@kenati.com>
	 <4410F1BE.7000904@kenati.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 22:25:51 -0500
Message-Id: <1141961152.13319.118.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 19:25 -0800, Carlos Munoz wrote:
> I figured out how to get the driver to use floating point operations.
> I included source code (from an open source math library) for the
> log10 function in the driver. Then I added the following lines to the
> file arch/sh/kernel/sh_ksyms.c: 

Where is the source code to your driver?

Lee

