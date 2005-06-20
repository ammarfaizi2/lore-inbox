Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVFTR4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFTR4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVFTR4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:56:08 -0400
Received: from urchin.mweb.co.za ([196.2.24.26]:7757 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S261405AbVFTR4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:56:03 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: niraj17@iitbombay.org
Subject: Re: Hi,make question
Date: Mon, 20 Jun 2005 19:56:07 +0200
User-Agent: KMail/1.8.50
Cc: guorke <gourke@gmail.com>, linux-kernel@vger.kernel.org
References: <d73ab4d005061918441ae4a81f@mail.gmail.com> <d73ab4d005061922314a2cadb5@mail.gmail.com> <b82a891705062000144a0c3f81@mail.gmail.com>
In-Reply-To: <b82a891705062000144a0c3f81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201956.07959.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 09:14 am, Niraj kumar wrote:
> On 6/20/05, guorke <gourke@gmail.com> wrote:
> > > 1. What kernel are you currently runnig
> <snip>
> > I meet lot of  Segmentation fault.
> > So I must make again and agian.
> 
> Continuous segfault is usually sign of a hardware/memory issue .
> 
> You may like to try memtest86 .
> 
> Niraj
> 
>

If you haven't tried to update your system's glibc (or maybe partial upgrade), then try running memtest86
