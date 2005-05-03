Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVECT77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVECT77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVECT77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:59:59 -0400
Received: from palrel12.hp.com ([156.153.255.237]:64483 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261659AbVECT7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:59:45 -0400
Date: Tue, 3 May 2005 12:59:39 -0700
To: Chris Hessing <Chris.Hessing@utah.edu>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Benjamin Reed <breed@zuzulu.com>, Jouni Malinen <jkmaline@cc.hut.fi>,
       chessing@users.sourceforge.net
Subject: Re: [PATCH] dynamic wep keys for airo.c
Message-ID: <20050503195939.GA19741@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050503183335.GA19691@bougret.hpl.hp.com> <4277C8CA.5070503@utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4277C8CA.5070503@utah.edu>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 12:54:02PM -0600, Chris Hessing wrote:
> 
> I agree completely with Jean.  In fact, the needed patch to use 
> IW_ENCODE_TEMP is already in Xsupplicant.  However, to remain on the 
> conservative side I have provided a command line switch to disable the 
> use of IW_ENCODE_TEMP.  (Although I don't know of anything that would 
> require it.)
> 
> There was a new pre-release of Xsupplicant yesterday that will make use 
> of IW_ENCODE_TEMP.  Please let me know if anything additional is needed.

	Wow ! That's even better ! Thanks a lot !

> Thanks!

	Jean
