Return-Path: <linux-kernel-owner+w=401wt.eu-S965059AbXAJUFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbXAJUFy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 15:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbXAJUFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 15:05:53 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:33446 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965059AbXAJUFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 15:05:53 -0500
Date: Wed, 10 Jan 2007 21:05:10 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Lei W <leiw.again@yahoo.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: Jumping into Kernel development: About -rc kernels...
Message-ID: <20070110210510.56a36788@localhost>
In-Reply-To: <45A52B64.7070904@s5r6.in-berlin.de>
References: <20070110150051.63974.qmail@web15914.mail.cnb.yahoo.com>
	<45A52B64.7070904@s5r6.in-berlin.de>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007 19:07:32 +0100
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> On 1/10/2007 4:00 PM, Lei W wrote:
> > If now i have applied patch-2.6.19.1,how can i goto
> > 2.6.20-rc4 ?
> 
> $ cd linux/
> $ patch -p1 -R < patch-2.6.19.1
> $ patch -p1 < patch-2.6.20-rc4

for Lei W:

	cd linux/
	ketchup 2.6.20-rc4

http://www.selenic.com/ketchup/wiki/

:)

-- 
	Paolo Ornati
	Linux 2.6.20-rc4-gf3a2c3ee on x86_64
