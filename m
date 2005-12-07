Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbVLGTFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbVLGTFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbVLGTFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:05:18 -0500
Received: from palrel12.hp.com ([156.153.255.237]:33413 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1751765AbVLGTFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:05:16 -0500
Date: Wed, 7 Dec 2005 11:05:12 -0800
To: Jiri Benc <jbenc@suse.cz>, netdev@vger.kernel.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Michael Renzmann <netdev@nospam.otaku42.de>,
       Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051207190512.GA1993@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20051206224728.GA31894@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206224728.GA31894@bougret.hpl.hp.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 02:47:28PM -0800, jt wrote:
> 
> MadWifi stack :
> 	drivers using it : MadWifi (non GPL)
> 	drivers in progress : FreeHAL Atheros, Prism54 softMAC, ural-ralink

	Sam kindly pointed out that my statement above may be
confusing. It should read :

MadWifi stack :
	drivers using it : Atheros (binary blob)
	drivers in progress : FreeHAL Atheros, Prism54 softMAC, ural-ralink

	Accept my apologies for the error.

	Jean
