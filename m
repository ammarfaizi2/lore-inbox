Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274997AbTHQCRe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 22:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275000AbTHQCRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 22:17:34 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17280 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S274997AbTHQCRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 22:17:33 -0400
Date: Sat, 16 Aug 2003 22:16:43 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Ram?n Rey Vicente???? <ramon.rey@hispalinux.es>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test3-current] drivers/pnp/core.c:72: error: structure has	no member named `name'
Message-ID: <20030816221642.GA7704@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Ram?n Rey Vicente???? <ramon.rey@hispalinux.es>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1061076005.1304.34.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061076005.1304.34.camel@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 01:20:07AM +0200, Ram?n Rey Vicente???? wrote:
> Hi.
> 
> It seems the struct dev.name was removed from include/linux/device.h and
> should be implemented for every susbsystem. 

This has been corrected in the current bk tree.

Thanks,
Adam
