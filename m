Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWGPJie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWGPJie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 05:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWGPJie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 05:38:34 -0400
Received: from mail.gmx.de ([213.165.64.21]:19396 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750828AbWGPJid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 05:38:33 -0400
X-Authenticated: #5082238
Date: Sun, 16 Jul 2006 10:45:54 +0200
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Huge problem with XFS/iCH7R
Message-ID: <20060716084554.GC6370@server.c-otto.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 09:51:45PM +0200, Carsten Otto wrote:
> System (with software raid 5, XFS, four disks connected to AHCI
> controller) crashes very often and loses data.

An underdimensioned power supply was the main problem (and a XFS bug
killed some files).
-- 
Carsten Otto
c-otto@gmx.de
www.c-otto.de
