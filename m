Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTE0S36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTE0S36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:29:58 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:38662 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264045AbTE0S3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:29:03 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Artemio <artemio@artemio.net>, linux-kernel@vger.kernel.org
Subject: Re: HELP: No framebuffer option in config
Date: Tue, 27 May 2003 20:41:44 +0200
User-Agent: KMail/1.5.2
References: <200305272130.50993.artemio@artemio.net>
In-Reply-To: <200305272130.50993.artemio@artemio.net>
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305272041.44518.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 20:30, Artemio wrote:

Hi Artemio,

> Hello.
>
> I have a clean 2.4.20 kernel.
> I run "make menuconfig" but I can't see the "Frame-buffer support" section
> in "Console drivers" menu.
please do this:

1. make menuconfig
2. Code maturity level options  --->
3. [*] Prompt for development and/or incomplete code/drivers

after selecting 3rd, you should see it in: "Console drivers"

> What should I do to bring it back into config menu?
please read above ;)

ciao, Marc

