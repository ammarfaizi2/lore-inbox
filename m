Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUHFP5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUHFP5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUHFPuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:50:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29841 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268153AbUHFPra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:47:30 -0400
Message-ID: <4113A69B.5020907@pobox.com>
Date: Fri, 06 Aug 2004 11:41:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Paul Jakma <paul@clubi.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org> <1091795565.16307.14.camel@localhost.localdomain> <41138C67.7040306@rtr.ca> <Pine.LNX.4.60.0408061453410.2622@fogarty.jakma.org> <41139CE0.1040106@rtr.ca>
In-Reply-To: <41139CE0.1040106@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>  >If that is so then this suggests the drive has a far
>  >more serious problem than just a single bad block, right?
> 
> The smartmontools can answer that question far more reliably
> than anyone here can.


if libata supported SMART, which it doesn't yet.

So much to do, so little time...  :/

	Jeff


