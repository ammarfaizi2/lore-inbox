Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTEDSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTEDSg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:36:57 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:64260 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S261603AbTEDSg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:36:57 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305041839.TAA04514@gw.chygwyn.com>
Subject: Re: DECNET in latest BK
To: romieu@fr.zoreil.com (Francois Romieu)
Date: Sun, 4 May 2003 19:39:30 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <20030503203908.A5915@electric-eye.fr.zoreil.com> from "Francois Romieu" at May 03, 2003 08:39:08 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> David S. Miller <davem@redhat.com> :
> [...]
> > Turn off CONFIG_DECNET_ROUTE_FWMARK, aparently even the maintainer
> > doesn't even enable this option :-)
> 
> Does the attached patch make sense ?
>
Yes, I can confirm thats the right fix. I was a bit busy last week and my fix
didn't make it in time, but I'm back now and so the rest of my pending DECnet
patches will be submitted shortly. Thanks for the patch,

Steve.

