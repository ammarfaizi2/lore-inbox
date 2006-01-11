Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWAKMd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWAKMd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWAKMd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:33:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:29426 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751418AbWAKMd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:33:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels - patch1
Date: Wed, 11 Jan 2006 12:33:20 +0000
User-Agent: KMail/1.9.1
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>, netdev <netdev@vger.kernel.org>,
       SP <pereira.shaun@gmail.com>
References: <1136871078.5742.26.camel@spereira05.tusc.com.au> <200601101203.59423.arnd@arndb.de> <1136960688.5347.6.camel@spereira05.tusc.com.au>
In-Reply-To: <1136960688.5347.6.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200601111233.21075.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 06:24, Shaun Pereira wrote:
>  Thanks for reviewing those patches, and your feedback. I have made the
> changes recommended. If these are acceptable, I will build a proper
> [PATCH] for submission.

This patch looks good to me now.

> Is there anyone in particular that I need to mail 
> in order that these patches go into the next release? 

I guess David Miller should be on Cc:, but I'm not sure who would
be the one to forward general networking patches. The MAINTAINERS
file only lists netdev@vger.kernel.org.

	Arnd <><
