Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275222AbTHRXeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 19:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275227AbTHRXeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 19:34:23 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:21474 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S275222AbTHRXeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 19:34:21 -0400
Date: Tue, 19 Aug 2003 01:34:32 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Daniel Pezoa <dpforos@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patches question
Message-ID: <20030818233432.GA29563@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Daniel Pezoa <dpforos@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030818232539.86135.qmail@web11201.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030818232539.86135.qmail@web11201.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 04:25:39PM -0700, Daniel Pezoa wrote:
> Hello Kernel Community
> 
> I have one linux distribution, with the kernel
> linux-2.4.21-pre5-ac3, and i want to know what is the
> purpose of this patches:
> 
> patch-2.4.21-pre5
 -preX means that it actually is a prerelease kernel

  2.4.20	stable kernel release
 -------------- new features for next release
  2.4.21-pre1	prerelease 1
  ...
  2.4.21-preN	prerelease N
 -------------- feature freeze ...
  2.4.21-rc1	release candidate 1
  ...
  2.4.21-rcM	release candidate M
  2.4.21	stable release

> patch-2.4.21-pre5-ac3

 -acY means that it is one of Alan Cox's patchsets
      adding a bunch of fixes/drivers/etc not yet
      in the mainstream kernel ...

> Why should be are used, and where can i learn more
> about them??

 http://www.kernel.org/

 read the Changelogs, there you'll find some info ...
 
> Thanks for your help and Good luck!!

HTH,
Herbert

> Daniel Pezoa
