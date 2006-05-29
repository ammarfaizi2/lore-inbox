Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWE2XNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWE2XNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWE2XNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:13:54 -0400
Received: from quechua.inka.de ([193.197.184.2]:2519 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932084AbWE2XNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:13:53 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060529122536.GE22245@boogie.lpds.sztaki.hu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fkqvn-0001ts-00@calista.eckenfels.net>
Date: Tue, 30 May 2006 01:13:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor Gombas <gombasg@sztaki.hu> wrote:
> No. Hostname does not have to resolve to _anything_. The hostname is
> just a string that identifies the machine for _humans_. It is nothing
> more, nothing less. It follows that a hostname should be just as unique
> as it's human users are concerned, it has no relation to subnets or
> FQDN or any other network term.

There are some (common) applications which bind more meaning to that string.
Most noteable MTAs if they are configured to detect things automatically.
The kernel does not care (well I do ignore some exotic cluster, dlm,
remote-ipc, security stacks)

Gruss
Bernd
