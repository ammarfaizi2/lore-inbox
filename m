Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVHaNLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVHaNLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVHaNLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:11:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:37804 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964788AbVHaNLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:11:04 -0400
Subject: Re: KLive: Linux Kernel Live Usage Monitor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sven Ladegast <sven@linux4geeks.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508310117230.1930@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random>
	 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
	 <1125412611.8276.9.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0508310033400.1930@cassini.linux4geeks.de>
	 <1125444317.13646.6.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0508310117230.1930@cassini.linux4geeks.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 14:34:57 +0100
Message-Id: <1125495297.3355.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-31 at 01:19 +0200, Sven Ladegast wrote:
> On Wed, 31 Aug 2005, Alan Cox wrote:
> 
> > "Register a box + optional PCI id list/CPU info"
> > Reply with a secured serial number
> 
> Registering means to create an ID for the system? Something out of 
> timestamp plus your PCI IDs and CPU info and so on?

Or have the other end issue you some kind of secure cookie, which was my
thought. Generating it locally as you suggest would be even better as a
hardware change would make a box change identity automatically

