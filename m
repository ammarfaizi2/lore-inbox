Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVGNAT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVGNAT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVGNAJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:09:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6361 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261594AbVGNAHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:07:19 -0400
Date: Thu, 14 Jul 2005 02:06:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: =?UTF-8?Q?Egry_G=E1bor?= <gaboregry@t-online.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
In-Reply-To: <1121273456.2975.3.camel@spirit>
Message-ID: <Pine.LNX.4.61.0507140152550.3743@scrub.home>
References: <1121273456.2975.3.camel@spirit>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-373779721-1121299609=:3743"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-373779721-1121299609=:3743
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 13 Jul 2005, Egry G=E1bor wrote:

> The following patches complete the "Kconfig I18N support" patch by
> Arnaldo.=20

First I'd really like to see some documentation on this, which describes=20
the interface how tools/distributions can provide Kconfig I18N support.

> - answering (Y/M/N)

This one is just silly. Provide a nice helptext, which describes what that
means, for xconfig I'm also accepting nice descriptive icons.

bye, Roman
---1463811837-373779721-1121299609=:3743--
