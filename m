Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130750AbRCEXN6>; Mon, 5 Mar 2001 18:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130757AbRCEXNs>; Mon, 5 Mar 2001 18:13:48 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:21514 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S130756AbRCEXNb>; Mon, 5 Mar 2001 18:13:31 -0500
Date: Mon, 5 Mar 2001 15:13:24 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <20010305235629.A1136@werewolf.able.es>
Message-ID: <Pine.LNX.4.31ksi3.0103051507140.12620-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, J . A . Magallon wrote:

> What that line does is to build a tool (aicasm) to generate the ucode
> that
> is built into the kernel (afaik, it is a kind of assembler from a
> language
> to AIC sequencer code). That is, the tool uses db1 (as mkdep.c uses
> glibc)
> but once you have generated the sequencer instructions, that is what is
> built
> into the kernel, not the tool (aicasm).

It's very nice... Now one should have not only special kgcc to build the
kernel, but also the obsolete library with all the development stuff
installed... Is it sane?

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

