Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbTL3FQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTL3FQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:16:55 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:46513 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265094AbTL3FQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:16:54 -0500
Message-Id: <6.0.1.1.2.20031230155431.022253f0@mail.optusnet.com.au>
X-Nil: 
Date: Tue, 30 Dec 2003 16:15:10 +1100
To: david.lang@digitalinsight.com
From: Leon Toh <tltoh@attglobal.net>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel
  Configuration Tool
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312290340010.3163@dlang.diginsite.com>
References: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com>
 <3FEF721D.7020405@rackable.com>
 <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au>
 <Pine.LNX.4.58.0312290340010.3163@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:40 PM 29/12/2003, David Lang wrote:
>On Mon, 29 Dec 2003, Leon Toh wrote:
>
> > By the way I've hack the script file to make Adaptec I2O Option to appear
> > in Linux 2.6.0 Kernel Configuration tool. Currently I'm now in the middle
> > of recompiling the kernel using current dpti2o driver support but haven't
> > got to the dpti2o driver yet.
>
>did you doublecheck that it wasn't just blocked by not choosing to allow
>you to compile known broken drivers?

The driver is broken anyway. Will have a case open up and escalated.

