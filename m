Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbTFNLnD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 07:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265668AbTFNLnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 07:43:03 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:1165 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S265667AbTFNLnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 07:43:01 -0400
Date: Sat, 14 Jun 2003 13:56:48 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ravi Kumar Munnangi <munnangi_ivar@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel panic:I have no root I want to scream
In-Reply-To: <20030614111834.477.qmail@web20508.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0306141347310.19166-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make xconfig
>   During the configuration I havn't made any changes to
>    the default configuration.I have just saved the
>    default configuration and exited.

You should have, unless you have exactly the same configuration as Linus
Torvalds has.
Probably drivers for accessing the root filesystem are missing, but you
also need to configure a whole heap of other things as well.

The Kernel Howto at
  http://www.linux.org/docs/ldp/howto/Kernel-HOWTO/
makes a good reading.

