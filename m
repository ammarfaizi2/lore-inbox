Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbUASQZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 11:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUASQZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 11:25:27 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:42963 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265299AbUASQZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 11:25:25 -0500
Date: Mon, 19 Jan 2004 08:24:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.6.1-uc0 (MMU-less fix ups)
Message-ID: <20040119162459.GP1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Greg Ungerer <gerg@snapgear.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <400BD910.2000608@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400BD910.2000608@snapgear.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 11:18:08PM +1000, Greg Ungerer wrote:
> 
> Hi All,
> 
> An update of the uClinux (MMU-less) fixups against linux-2.6.1.
> Quite a few small fixes here, mostly carried forward from previous
> patch sets. One important new fix to the page_alloc code for MMUless
> systems.
> 

Have you submitted any of these to Andrew?
