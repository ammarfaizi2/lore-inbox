Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270673AbTG0FYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 01:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270674AbTG0FYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 01:24:38 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:19723 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270673AbTG0FYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 01:24:38 -0400
From: Marino Fernandez <mjferna@yahoo.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0 wont let me unmount eth0 upon reboot
Date: Sun, 27 Jul 2003 00:39:51 -0500
User-Agent: KMail/1.5.2
References: <E19gdHW-0004zt-00@gondolin.me.apana.org.au>
In-Reply-To: <E19gdHW-0004zt-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270039.52172.mjferna@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 11:37 pm, Herbert Xu wrote:
> Marino Fernandez <mjferna@yahoo.com> wrote:
> > I've trying the new kernel. Everything is OK, except that when I shut
> > down my machine, I get this message:
> >
> > unmounting remote filesystems
> > unregistering_netdevice: waiting for eth0 to become free. usage count =
> > -4
>
> Disabled CONFIG_IPV6_PRIVACY or run the latest BK source.

Thanks, but II don't have it enabled... 

