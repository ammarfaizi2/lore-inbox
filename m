Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUH3ORc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUH3ORc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUH3ORc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:17:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:46209 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266749AbUH3ORb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:17:31 -0400
Subject: Re: Celistica with AMD chip-set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0408300955470.21607@chaos>
References: <Pine.LNX.4.53.0408300955470.21607@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093871709.30082.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 Aug 2004 14:15:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-30 at 15:02, Richard B. Johnson wrote:
> Hello all,
> 
> The Celistica server with the AMD chip-set has very poor
> PCI performance with Linux (and probably W$ too).
> 
> The problem was traced to incorrect bridge configuration
> in the HyperTransport(tm) chips that connect up pairs
> of slots.

Can you get Celestica to mail me their PCI subvendor
id/devid's for the problem configuration or DMI strings
and then we can do a PCI quirk properly for this.

Alan

