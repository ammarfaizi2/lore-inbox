Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUAZRSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 12:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUAZRSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 12:18:52 -0500
Received: from palrel12.hp.com ([156.153.255.237]:23514 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264583AbUAZRSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 12:18:51 -0500
Date: Mon, 26 Jan 2004 09:18:34 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net,
       jgarzik@pobox.com, lists@mdiehl.de
Subject: Re: New IrDA drivers for 2.6.X
Message-ID: <20040126171834.GA16161@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040124021828.GA22410@bougret.hpl.hp.com> <20040123.224124.71115576.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123.224124.71115576.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 10:41:24PM -0800, David S. Miller wrote:
>    From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
>    Date: Fri, 23 Jan 2004 18:18:28 -0800
>    
>    	Martin Diehl has finished converting all the old style dongle
>    driver to the new API. This was the last major feature parity issue
>    with 2.4.X, with this work, 2.6.X should support all the IrDA serial
>    dongles that 2.4.X supports. Martin also did a few other cleanups and
>    fixed tekram-sir so that it works with real hardware.
> 
> All applied.  I'll queue this up.  I'll try to get it in
> now but it may be deferred to the next 2.6.x release.

	No problem. Thanks !

	Jean
