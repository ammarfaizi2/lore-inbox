Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUHFPBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUHFPBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUHFPBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:01:18 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:52895 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266001AbUHFPA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:00:56 -0400
Message-ID: <41139CE0.1040106@rtr.ca>
Date: Fri, 06 Aug 2004 10:59:44 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org> <1091795565.16307.14.camel@localhost.localdomain> <41138C67.7040306@rtr.ca> <Pine.LNX.4.60.0408061453410.2622@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.60.0408061453410.2622@fogarty.jakma.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >If that is so then this suggests the drive has a far
 >more serious problem than just a single bad block, right?

The smartmontools can answer that question far more reliably
than anyone here can.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
