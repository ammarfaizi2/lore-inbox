Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWFTXRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWFTXRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWFTXRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:17:01 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:31472 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932133AbWFTXRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:17:00 -0400
Message-ID: <449881DE.4090606@myri.com>
Date: Tue, 20 Jun 2006 19:16:46 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andi Kleen <ak@suse.de>, Dave Olson <olson@unixfolk.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de> <20060620212908.GA17012@suse.de> <44987661.5050907@myri.com> <20060620230533.GB16598@suse.de>
In-Reply-To: <20060620230533.GB16598@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> No, that's not fair for those devices which do not have PCI-E and yet
> have MSI (the original ones, that work just fine...)
>
> Again, no "whitelist" please, just quirks to fix problems with ones that
> we know we have problems with, just like all other PCI quirks...
>
> thanks,
>
> greg k-h
>   

Ok I will regenerate my patches to do so.

Brice

