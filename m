Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHZPJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTHZPJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:09:22 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:3485 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261180AbTHZPJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:09:20 -0400
Subject: Re: Interesting problem with 450NX based Compaq server
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Bryan Ballard <ballard@netsolus.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030825225820.2d1c6e29.akpm@osdl.org>
References: <1061875433.24196.15.camel@ant>
	 <20030825225820.2d1c6e29.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061910515.20846.43.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 26 Aug 2003 16:08:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-26 at 06:58, Andrew Morton wrote:
> I have an Intel ad450nx server, based on the 450NX PCISet chipset. 
> 4x500MHz Xeons.  It runs like a champ.

450NX does have bugs (browse the intel pdf). None of them I can see
should bite people unless they are using mtrr ranges or have out of
date bioses.

