Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTH0Wl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTH0Wl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:41:28 -0400
Received: from [62.241.33.80] ([62.241.33.80]:11782 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262436AbTH0Wl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:41:27 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux-2.2 future?
Date: Thu, 28 Aug 2003 00:40:33 +0200
User-Agent: KMail/1.5.3
Cc: adefacc@tin.it, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ruben =?iso-8859-15?q?P=FCttmann?= <ruben@puettmann.net>,
       Ville Herva <vherva@niksula.hut.fi>
References: <3F468ABD.1EBAD831@tin.it> <200308251815.20131.m.c.p@wolk-project.de> <1061910188.20846.39.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1061910188.20846.39.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308280034.19050.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 17:03, Alan Cox wrote:

Hi Alan,

> The problem is that change breaks stuff. a lot of the 2.2 users will
> happily trade lack of LBA48 support for stability and predictability.
> Thats why I took a basically "if its not a serious bugfix its not going
> in" approach

Yeah, I agree with you. Anyway, I've never said I will integrate that IDE 
stuff when I become the 2.2 maintainer :) ... I just said I'll think about it 
;) ... I never ever want to break 2.2, and such an update will definitively 
break things. 2.2 took a long time to become that stable like it is now and it 
can be broke within minutes. A no-go!

For users who need/want/experiment with that stuff there is still my 
2.2-secure tree.

Anyway, 2.2 needs the hashing exploit fix ASAP ;)

ciao, Marc

