Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUAQV7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 16:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUAQV7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 16:59:16 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:57315 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S266184AbUAQV7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 16:59:15 -0500
Date: Sat, 17 Jan 2004 13:59:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Condor <condor@vereya.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 may be bug in prints.c:341
Message-ID: <20040117215908.GA1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Condor <condor@vereya.net>, linux-kernel@vger.kernel.org
References: <00e201c3dd32$25bde0d0$8648493e@ixip.net> <20040117195151.GY1748@srv-lnx2600.matchmail.com> <010801c3dd37$1ff2ee20$8648493e@ixip.net> <20040117202324.GZ1748@srv-lnx2600.matchmail.com> <012001c3dd38$fcb89c50$8648493e@ixip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012001c3dd38$fcb89c50$8648493e@ixip.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 10:31:42PM +0200, Condor wrote:
> I not use ksymoops.

EXACTLY!

The trace is unusable to anyone until you run it through ksymoops...

And as oleg said, you have hardware problems, so you should fix that.
