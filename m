Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSFXSCH>; Mon, 24 Jun 2002 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSFXSCG>; Mon, 24 Jun 2002 14:02:06 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:3325 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S314584AbSFXSCE>; Mon, 24 Jun 2002 14:02:04 -0400
Date: Mon, 24 Jun 2002 11:04:08 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map )
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Nick Bellinger'" <nickb@attheoffice.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Message-id: <3D175F18.4020000@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <59885C5E3098D511AD690002A5072D3C02AB7F53@orsmsx111.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>No, of course driverfs isn't for everything.  But if it's not 
>>for all drivers,
>>then what's it for -- just power management?
>  
> "Just" power management??? Like power management isn't important enough???
> ;-)

Well, it's only one of the roles I'd expect of a "driver filesystem",
and actually no -- not the most important one.  If instead it were
called "powermanagementfs" ... or if it were renamed to that ... :)


> We need a device tree to do PM. If driverfs's PM capabilities are hurt
> because it doesn't stay true to that, then the featureitis has gone too far.

And for other reasons, we also need one.  I don't think you've actually
pointed out any concrete problems for PM though.

- Dave



