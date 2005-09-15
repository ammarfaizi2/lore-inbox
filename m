Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVIOIMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVIOIMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVIOIMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:12:17 -0400
Received: from web51005.mail.yahoo.com ([206.190.38.136]:11605 "HELO
	web51005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750913AbVIOIMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:12:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bVmst/BquEgFewhyzIO5miuxKE85d1MzhFjW+2PpkVvPp3OAHW5rN+9ge7j05NgumCRgzDRGLhP87+C9m2eHmjvZyQ/xY3Kb33U8hVtRqefzQJxEWMTSjePdryY34JIJwK3XcAgedIjjXamDQt6nHC1KEUQOWfyl7+AbtbmGfUk=  ;
Message-ID: <20050915081214.53141.qmail@web51005.mail.yahoo.com>
Date: Thu, 15 Sep 2005 01:12:14 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
To: Lee Revell <rlrevell@joe-job.com>, Daniel Thaler <thalerd@in.tum.de>
Cc: David Lang <dlang@digitalinsight.com>, Hua Zhong <hzhong@gmail.com>,
       marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <1126757808.13893.125.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2005-09-15 at 05:37 +0200, Daniel Thaler
> wrote:
> > Lee Revell wrote:
> > > Why does this have to be in the kernel again? 
> Isn't this exactly what
> > > you get with a fully modular config and hotplug?
> > 
> > It doesn't go in the kernel. If I understand
> correctly, it's a script that is 
> > invoked by 'make autoconfig'. Note that I didn't
> read the patch, because it's a 
> > .tgz on a website and I couldn't be bothered to
> download it.
> 
> Oh, sorry.  Then read that as "what's the point"?
> 
> Lee
> 
It does go in the Kernel. The files are all kept in
the directory <KERNEL>/scripts/kconfig/.
And I changed a little bit the Makefile and the conf.c
in the <KERNEl>/scrips/kconfig. 




		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
