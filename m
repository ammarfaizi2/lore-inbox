Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317031AbSFWOsi>; Sun, 23 Jun 2002 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317032AbSFWOsh>; Sun, 23 Jun 2002 10:48:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49595 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317031AbSFWOsh>;
	Sun, 23 Jun 2002 10:48:37 -0400
Date: Sun, 23 Jun 2002 07:45:31 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <4164497961.1024818330@[10.10.2.3]>
In-Reply-To: <Pine.NEB.4.44.0206161317410.11043-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0206161317410.11043-100000@mimas.fachschaften.tu-muenchen.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this problem with CONFIG_MULTIQUAD does also exist in 2.4 kernels. Could
> you provide a patch against 2.4.19-pre10?

Apologies for slow (and somewhat unhelpful) reply.
I'm out of town from June 17th - July 8th, and won't have 
a chance to look at this until then. If you want something 
urgently, the patch I posted for -dj should backport pretty
easily, assuming the problem is the same, else I'll look at 
it when I get back.

M.

