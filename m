Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSGRKZ0>; Thu, 18 Jul 2002 06:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317766AbSGRKZ0>; Thu, 18 Jul 2002 06:25:26 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51443 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317742AbSGRKZZ>; Thu, 18 Jul 2002 06:25:25 -0400
Subject: Re: kernel patch problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Lim <Daniel.Lim@dpws.nsw.gov.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <sd369c76.061@out-gwia.dpws.nsw.gov.au>
References: <sd369c76.061@out-gwia.dpws.nsw.gov.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 12:39:22 +0100
Message-Id: <1026992362.8154.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 01:45, Daniel Lim wrote:
> Hi,
> I have Redhat 7.1 kernel 2.4.2-2 and I wish to apply all latest
> incremental patches from 2.4.3 -> 2.4.18 to resolve a kernel issue but I
> am having problem to apply the 1st patch which is 2.4.3, I got the
> patch-2.4.3.gz from http://www.linuxhq.com/kernel 
> 
Last I checked 2.4.18 was smaller than the set of patches. Where did you
get your 2.4.2 base tree from. The Red Hat one has patches to fix a lot
of 2.2 bugs, but you can find the original tar ball (plus patches) if
you install the kernel source RPM and look in /usr/src/redhat/SOURCES


