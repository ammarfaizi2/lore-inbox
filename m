Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWE0COy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWE0COy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 22:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWE0COy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 22:14:54 -0400
Received: from quechua.inka.de ([193.197.184.2]:46278 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751765AbWE0COy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 22:14:54 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060526211140.GC16059@hermes.uziel.local>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FjoKK-0003SN-00@calista.inka.de>
Date: Sat, 27 May 2006 04:14:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Trefzer <ctrefzer@gmx.de> wrote:
> 127.0.0.1     localhost.localdomain    localhost
> 192.168.x.y   host.domain.tdl          host
> 
> Major catch: it presumes you have at least one NIC actually in use. If
> lo is the absolute sole interface, one might map every single hostname
> to that one as well. Schizophrenia is fun, solitude is gone for good : )

You can use "127.0.0.2 host.doma.in host" in /etc/hosts if you dont have
another interface, or if it changes regularly.

Gruss
Bernd
