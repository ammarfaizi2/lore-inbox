Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbUAMRuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUAMRuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:50:15 -0500
Received: from [195.166.20.93] ([195.166.20.93]:60388 "EHLO
	frumious.unidec.co.uk") by vger.kernel.org with ESMTP
	id S265321AbUAMRuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:50:11 -0500
Message-Id: <200401131750.i0DHoMF2009244@frumious.unidec.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: dr john halewood <john@frumious.unidec.co.uk>
Reply-To: john@frumious.unidec.co.uk
To: gj@pointblue.com.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.4.24+grsec compilation issue
Date: Tue, 13 Jan 2004 17:50:21 +0000
X-Mailer: KMail [version 1.3.2]
References: <200401122142.06931.gj@pointblue.com.pl>
In-Reply-To: <200401122142.06931.gj@pointblue.com.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 Jan 2004 9:42 pm, Grzegorz Jaskiewicz wrote:
>Recently i tried to compile 2.4.24+grsec kernel.
>I am getting error:
>
>/usr/src/linux-2.4.24/arch/i386/vmlinux.lds:116 invalid assignment to
> location counter

It's a problem with the grsecurity patch., not the kernel, and should really 
be on a grsecurity mailling list. However, I can tell you that it works 
properly if you use stock kernel 2.4.24 with the grsecurity 
1.9.13-2.4.23.patch.

cheers
john
