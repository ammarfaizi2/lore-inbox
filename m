Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWIBIxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWIBIxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 04:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWIBIxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 04:53:44 -0400
Received: from web36708.mail.mud.yahoo.com ([209.191.85.42]:28546 "HELO
	web36708.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750887AbWIBIxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 04:53:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iT413CBfSIFatN4vaU/ZUtXD1JhPKDxy/4sUvVi+0VrlCcvutxhgCD+WYXuUuSo06945ZYpY/mmnTInBkEq1Vh29QjgEBuIp0D+V//TX17bCWvEV6v1uqffHiWdG7pv7MR2JxhCPnuHMRQ5KGxXOls+huTEllNm5OP/TrvU2mzQ=  ;
Message-ID: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com>
Date: Sat, 2 Sep 2006 01:53:42 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44D070E7.3080707@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.
I've made a couple of fixes to my flashmedia driver
(http://developer.berlios.de/projects/tifmxx/) to the
effect of much improved R/W speed in PIO mode and
writing speed in DMA mode.
I also tried to clean-up reverse engineering mess out
of the code - it should be more readable now.

Next on my list is MemoryStick functionality.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-- 
VGER BF report: U 0.5
