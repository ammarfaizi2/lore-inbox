Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUHYXlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUHYXlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUHYXlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:41:52 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:18180 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266508AbUHYXli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:41:38 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: predivan@ptt.yu
Subject: Re: Two .rej files when patching from 2.6.8.1 to 2.6.9-rc1
Date: Thu, 26 Aug 2004 01:41:30 +0200
User-Agent: KMail/1.7
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040826013136.72bd1906.predivan@ptt.yu>
In-Reply-To: <20040826013136.72bd1906.predivan@ptt.yu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408260141.31094.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 03:31, Predrag Ivanovic wrote:
> Hi.
>
> There are two .rej files when I patch 2.6.8.1 to 2.6.9-rc1
> (I ran 'make mrproper' when I unpacked 2.6.8.1 tarball).
> These are :

2.6.9-rc1 should be applied on top of 2.6.8 (and not 2.6.8.1).
