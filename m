Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265133AbRFZWbe>; Tue, 26 Jun 2001 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbRFZWbX>; Tue, 26 Jun 2001 18:31:23 -0400
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:20615 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S265133AbRFZWbL>; Tue, 26 Jun 2001 18:31:11 -0400
Date: Tue, 26 Jun 2001 16:31:01 -0600 (MDT)
From: james rich <james.rich@m.cc.utah.edu>
To: Ilya Konstantinov <lkml@future.galanet.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Finding out the name behind a /dev/dsp device
In-Reply-To: <20010626224409.A24182@goblin.sharat.co.il>
Message-ID: <Pine.GSO.4.05.10106261629210.18831-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, Ilya Konstantinov wrote:

> How can I find out the module name which handles a /dev/dsp* device
> and/or the full name of the Sound Card I'd be addressing by it?

If you use ALSA this is very simple.  See:

http://www.alsa-project.org

I feel that ALSA provides a superior audio driver.  I understand that the
it will become the default kernel driver.

James Rich
james.rich@m.cc.utah.edu

