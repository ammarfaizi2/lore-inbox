Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUA0A2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbUA0A2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:28:21 -0500
Received: from smtp02.ya.com ([62.151.11.161]:47020 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S265750AbUA0A2T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:28:19 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kernel BUG at include/linux/list.h:148!
Date: Tue, 27 Jan 2004 01:24:07 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, ender@debian.org
References: <200401270042.02840.ender@debian.org> <20040126161615.143b23b2.akpm@osdl.org>
In-Reply-To: <20040126161615.143b23b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401270124.07445.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Martes, 27 de Enero de 2004 01:16, Andrew Morton escribió:
> Someone else was seeing something similar.  Reverting
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm1/broken-out/sysfs-pin-kobject.patch
>
> apparently fixed it.

	Andrew, thank you very much for your prompt response.

	I'll try tomorrow, as it seemed to had hung and I need to go to the 
university to reboot it.

	Have you kicked it out of your next release? I see that is into 
2.6.2-rc1-mm3.

	Anyway I'll take a look and will report to you.

	Thanks again,


		Ender.
--
Network engineer
Debian developer

