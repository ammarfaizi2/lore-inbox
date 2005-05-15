Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVEOANs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVEOANs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 20:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVEOANr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 20:13:47 -0400
Received: from sa7.bezeqint.net ([192.115.104.21]:29069 "EHLO sa7.bezeqint.net")
	by vger.kernel.org with ESMTP id S261414AbVEOANq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 20:13:46 -0400
Date: Sun, 15 May 2005 03:32:03 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
To: Green Brain <greenbrain@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5 MODEM in NASM - pci_dev
Message-ID: <20050515003203.GA1483@tecr>
Mail-Followup-To: Green Brain <greenbrain@freemail.hu>,
	linux-kernel@vger.kernel.org
References: <002e01c558dc$485ed0f0$2f47c5d5@windows>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002e01c558dc$485ed0f0$2f47c5d5@windows>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01:09 Sun 15 May     , Green Brain wrote:
> I would like to write a kernel module (driver) to the ICH5 SmartLink
> SoftModem. The project is on my assembly.uw.hu website. If you can write PCI
> driver please help me!

There is already sound/pci/intel8x0m.c alsa pci driver for such modems.

Sasha.

