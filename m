Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSJ2WLM>; Tue, 29 Oct 2002 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSJ2WLM>; Tue, 29 Oct 2002 17:11:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:57984 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262392AbSJ2WLL>; Tue, 29 Oct 2002 17:11:11 -0500
Subject: Re: [BK SUMMARY] fix NGROUPS hard limit (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: thockin@sun.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210291932.g9TJWiC30564@scl2.sfbay.sun.com>
References: <200210291932.g9TJWiC30564@scl2.sfbay.sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Oct 2002 22:32:43 +0000
Message-Id: <1035930763.1332.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 19:32, Timothy Hockin wrote:
> Linus,
> 
> This patchset removes the hard NGROUPS limit.  It has been in use in a similar
> form (but with a sysctl-set limit) on our systems for some time.
> 
> I have a separate patch to convert XFS to the generic qsort(), which I will
> bounce to SGI if/when this gets pulled.

What is the worst case stack usage of your qsort ?

