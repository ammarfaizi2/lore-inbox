Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRJUMvi>; Sun, 21 Oct 2001 08:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbRJUMv3>; Sun, 21 Oct 2001 08:51:29 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:41620 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S275224AbRJUMvT>; Sun, 21 Oct 2001 08:51:19 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: Tim Jansen <tim@tjansen.de>
To: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Date: Sun, 21 Oct 2001 14:54:15 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya> <20011021093728.A17786@vega.digitel2002.hu>
In-Reply-To: <20011021093728.A17786@vega.digitel2002.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <15vI4j-1Z1VtgC@fmrl02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 09:37, Gábor Lénárt wrote:
> moved into kernel space :) IMHO it's strictly user space issue. You can
> start X or gdm/xdm/kdm from a boot script and so on. No kernel modification
> is needed for this.

But what the kernel COULD do is include something like the Linux Progress 
Patch (http://lpp.freelords.org/). It replaces the text output of the kernel 
with graphics and a progress bar, so people are not frightened by cryptic 
text output while booting.

bye...
