Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSHGOKa>; Wed, 7 Aug 2002 10:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSHGOKa>; Wed, 7 Aug 2002 10:10:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58617 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317980AbSHGOK3>; Wed, 7 Aug 2002 10:10:29 -0400
Subject: Re: PROBLEM: kernel BUG at page_alloc.c:117!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergio Avila <sergio@evoto.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208071509.30398.sergio@evoto.org>
References: <200208071509.30398.sergio@evoto.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 16:33:29 +0100
Message-Id: <1028734409.18478.302.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 14:09, Sergio Avila wrote:
> [1.] One line summary of the problem:
> 
>         kernel BUG at page_alloc.c:117!

>         Aug  7 04:17:25 lordvaider kernel: NVRM: AGPGART: freed 16 
> pages
>         Aug  7 04:17:25 lordvaider kernel: NVRM: AGPGART: backend 

Please report this to Nvidia. The linux community does not support or
care about bugs reported on any boot when their binary only modules have
been loaded

