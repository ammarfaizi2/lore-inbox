Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030600AbVKRNFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbVKRNFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030601AbVKRNFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 08:05:37 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:43992 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030600AbVKRNFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 08:05:36 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: Denis Vlasenko <vda@ilport.com.ua>,
       Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 18 Nov 2005 14:06:09 +0100
References: <58YAt-3Fs-5@gated-at.bofh.it> <59ecB-15H-13@gated-at.bofh.it> <59htx-69E-13@gated-at.bofh.it> <5acUX-PU-31@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Ed5wP-0000cs-VL@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Wednesday 16 November 2005 00:27, Giridhar Pemmasani wrote:

[because of ndiswrapper, ...]

> Companies got nice excuse for not giving us docs, making those
> months/years even longer.

<snip>

> Ok, how can we make any progress on obtaining docs for TI acx wireless
> chipset? Or on Prism54 "softmac" chipset? The reply is "Open source
> driver already exists (ndiswrapper), go away".

That why are these cards (Netgear WG511) are documented as being supported
in the CONFIG_PRISM54 help text. I asume the list was copied from the same
bad list of supported cards that made me buy one in the first place. If
there was no ndiswrapper support, I'd have been fooled to completely waste
my money, with ndiswrapper I can at least partially use it. I do neither
want to wait some years to use a by-then obsolete card nor can I help
developing a driver beyond doing some testing.

BTW: What about creating a "Native linux support" logo saying "If you find
a slot and plug it in, you can use it with a vanilla kernel on any arch and
get vendor support"? That would help against Netgear's faksimile products of
working models or ATI's claims for having "linux support".
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
