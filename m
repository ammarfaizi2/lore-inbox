Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUELKSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUELKSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 06:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUELKSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 06:18:51 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:54724 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S264933AbUELKSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 06:18:50 -0400
Date: Wed, 12 May 2004 13:19:45 +0300 (EEST)
From: Mihai Rusu <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
cc: debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Status field in ps output for threaded programs in 2.6 kernel
In-Reply-To: <200405121407.22551@zigzag.lvk.cs.msu.su>
Message-ID: <Pine.LNX.4.58L0.0405121317550.10059@ahriman.bucharest.roedu.net>
References: <200405121407.22551@zigzag.lvk.cs.msu.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Nikita V. Youshchenko wrote:

> Hello.
Hi

> Looks like kernel bug: displayed status of threaded process should not be 
> "S" if some threads are active. And CPU usage statistics should correspond 
> to all threads.

Hmm I dont know about that. A "solution" here is to have top also display
threads (like ps -m or ps -H of a recent procps distro).

> This happened on a Debian testing/unstable system, running kernel package 
> kernel-image-2.6.5-1-k7-smp 2.6.5-4.

-- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
