Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUGMOCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUGMOCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGMOCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:02:13 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:8457 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265051AbUGMOCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:02:05 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: lorenzo@gnu.org, pageexec@freemail.hu
Subject: Re: Kernel hacking option "Debug memory allocations" possible leak of PaX memory randomization
Date: Tue, 13 Jul 2004 16:01:39 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <1089726693.3283.21.camel@localhost>
In-Reply-To: <1089726693.3283.21.camel@localhost>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200407131601.39909@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 July 2004 15:51, Lorenzo Hernandez Garcia-Hierro wrote:

Hi Lorenzo,

> Is anyone of you having the same situation, is it an unexpected behavior or
> it's a bug on the kernel source?
> Is that option non-compatible with PaX RANDSTACK and the rest of PaX's
> memory randomization features?

CC pageexec at freemail dot hu - He's the PaX programmer.

ciao, Marc
