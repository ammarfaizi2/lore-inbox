Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUDZPDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUDZPDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUDZPDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:03:49 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:31105 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262756AbUDZPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:03:46 -0400
Date: Mon, 26 Apr 2004 17:03:43 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: David Johnson <dj@david-web.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anyone got aic7xxx working with 2.4.26?
Message-ID: <20040426150343.GC1461@louise.pinerecords.com>
References: <200404261532.37860.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404261532.37860.dj@david-web.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr-26 2004, Mon, 15:32 +0100
David Johnson <dj@david-web.co.uk> wrote:

> I was wondering if anyone had aic7xxx SCSI working with kernel 2.4.26?
> 
> It doesn't work on my Alpha (hangs the machine on boot) and I'm trying to find 
> out whether its an Alpha-specific issue or not, as I can't try the card in 
> another machine as it's in production.
> 
> I've also got the same problem with 2.6.5 (and newer) - but I think this is a 
> known issue with 2.6?

x86: both 2.4.26 and 2.6.6-rc2 work ok for me using aic7xxx.
The controllers driven are

00:10.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
00:12.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U

-- 
Tomas Szepe <szepe@pinerecords.com>
