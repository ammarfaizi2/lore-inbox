Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWCNWOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWCNWOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWCNWOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:14:35 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32951 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932518AbWCNWOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:14:34 -0500
Subject: Re: 2.6.16-rc6: known regressions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060313144244.266d96ef.akpm@osdl.org>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
	 <20060313200544.GG13973@stusta.de>  <20060313144244.266d96ef.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 22:18:36 +0000
Message-Id: <1142374716.3623.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-13 at 14:42 -0800, Andrew Morton wrote:
> Post-<tty changes, perhaps>
>   From: "Bob Copeland" <bcopeland@gmail.com>
>   Subject: 2.6.16-rc5 pppd oops on disconnects

Possibly although from an initial look I didn't see anything that
explained it and I still do see a lot of problems with USB serial and
USB error handling that might be USB or serial but predate the changes.


