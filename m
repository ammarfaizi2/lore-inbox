Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVBUPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVBUPFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVBUPFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:05:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:52134 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261996AbVBUPFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:05:02 -0500
Subject: Re: lockup when accessing serial port (and fix)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4207CFED.8020509@aknet.ru>
References: <4207CFED.8020509@aknet.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108998210.15518.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Feb 2005 15:03:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-02-07 at 20:30, Stas Sergeev wrote:
> Hello.
> 
> When I am trying to use the serial
> port, I am getting the machine lockup.
> This started to happen sometime in a
> 2.6.9 era I think, and is not fixed
> in the latest 2.6.11 pre's.

Known bug, just nobody has bothered to fix it. Please send the fix to
Linus so it gets into 2.6.11

