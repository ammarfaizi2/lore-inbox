Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271073AbTHQWLV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271091AbTHQWLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:11:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58634 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271073AbTHQWLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:11:20 -0400
Date: Mon, 18 Aug 2003 00:11:14 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NMI appears to be stuck! (2.4.22-rc2 on dual Athlon)
Message-ID: <20030817221114.GA734@alpha.home.local>
References: <20030817212824.GA9025@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817212824.GA9025@www.13thfloor.at>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 11:28:24PM +0200, Herbert P?tzl wrote:
> 
> Hi All!
> 
> Still no nmi_watchdog on dual Athlon systems?

Hi !

mine works fine only with nmi_watchdog=2. Don't know why. It's an ASUS A7M266D.

Cheers,
Willy

