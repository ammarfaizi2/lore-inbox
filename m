Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbTIKQdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTIKQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:33:07 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:28595 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S261395AbTIKQc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:32:56 -0400
Date: Thu, 11 Sep 2003 18:17:08 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre3-pac2
In-Reply-To: <1063294146.2967.32.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0309111814560.2212@dot.kde.org>
References: <Pine.LNX.4.56.0309111417580.31337@dot.kde.org>
 <1063294146.2967.32.camel@dhcp23.swansea.linux.org.uk>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, Alan Cox wrote:

> Cool stuff. I will probably put out a 22-ac3 later today to fix a couple
> of small glitches, can you send me the acpi=off oops fix if .22 needs it
> ?

The problem was introduced by a couple of ACPI fixes posted on lkml 
recently; they aren't in base or -ac2 yet.

You may want to add the whole set of patches though;
I've put the original patches at
http://www.arklinux.org/~bero/kernel/acpi-fixes.patch
and my fix for the Oops at
http://www.arklinux.org/~bero/kernel/acpioff.patch

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
