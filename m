Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVBYQr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVBYQr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 11:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVBYQr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 11:47:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6791 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262739AbVBYQrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 11:47:25 -0500
Subject: Re: linux-2.6.8.1 to linux-2.6.10: Kernel Patching Issues.
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10502251550520.26208-100000@mtfhpc.demon.co.uk>
References: <Pine.LNX.4.10.10502251550520.26208-100000@mtfhpc.demon.co.uk>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 11:47:23 -0500
Message-Id: <1109350044.9681.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 16:40 +0000, Mark Fortescue wrote:
> Hi all,
> 
> I am not sure exactly where to send this email. A have chosen the
> ip4/ip6 networking as the issues are in this area of the kernel.
>  
> The kernel patch files patch-2.6.9 and patch-2.6.10 do not apear to be
> correct.

No, you're doing it wrong.  2.6.8.1 was a bugfix release.  The correct
patching order is 2.6.8 -> 2.6.9 -> 2.6.10. 

Lee

