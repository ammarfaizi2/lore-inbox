Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUGUVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUGUVJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUGUVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:09:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54145 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266736AbUGUVJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:09:38 -0400
Date: Wed, 21 Jul 2004 17:09:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: sankarshana rao <san_wipro@yahoo.com>
cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Inode question
In-Reply-To: <20040721204602.35891.qmail@web50906.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0407211708040.18371@chaos>
References: <20040721204602.35891.qmail@web50906.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004, sankarshana rao wrote:

> Thx for the reply...
> When I try to call lookup() from my kernel module, it
> gives undefined symbol error during INSMOD..
> any clues???
>

It's probably not an exported symbol.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


