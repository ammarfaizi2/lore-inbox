Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUJHSe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUJHSe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJHSdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:33:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46257 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264098AbUJHSdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:33:12 -0400
Message-ID: <4166DD57.8060501@pobox.com>
Date: Fri, 08 Oct 2004 14:32:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       marcelo.tosatti@cyclades.com, klassert@mathematik.tu-chemnitz.de
Subject: Re: [patch 2.4.28-pre3] 3c59x: resync with 2.6
References: <20041008121307.C14378@tuxdriver.com> <20041008191324.J17999@flint.arm.linux.org.uk>
In-Reply-To: <20041008191324.J17999@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Ah, if someone's looking at the 3c59x driver then please look into the
> NWAY autonegotiation code - even maybe update it to use mii.c.


Steffen Klassert (cc'd) actually did a patch to do just that :)

	Jeff


