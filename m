Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWJFACK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWJFACK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWJFACK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:02:10 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:54294 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S932470AbWJFACI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:02:08 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/10] VIOC: New Network Device Driver
Date: Thu, 5 Oct 2006 16:53:38 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <netdev@vger.kernel.org>,
       bert hubert <bert.hubert@netherlabs.nl>
References: <200610051045.35760.misha@fabric7.com> <45255C7D.20309@garzik.org>
In-Reply-To: <45255C7D.20309@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051653.38706.misha@fabric7.com>
X-OriginalArrivalTime: 06 Oct 2006 00:02:07.0670 (UTC) FILETIME=[A9D8A560:01C6E8DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 12:26 pm, Jeff Garzik wrote:
> Misha Tomushev wrote:
> > The following patch series introduces the VIOC Device Driver, that
> > provides a network device inerface
> > to the internal fabric interconnected network used on servers designed
> > and built by Fabric 7 Systems.
>
> Please make this available somewhere as a single patch file.  It's
> easier to review, and we never merge new drivers as a series of patches.
>
> (granted, you need to split it up to get around the mailing list's 100K
> size limit)

The single patch file is available on ftp.fabric7.com/VIOC/vioc_patch.10_05_2006
-- 
Misha Tomushev
misha@fabric7.com


