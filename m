Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVHBLjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVHBLjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVHBLjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:39:31 -0400
Received: from sipsolutions.net ([66.160.135.76]:44294 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S261430AbVHBLja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:39:30 -0400
Message-ID: <42EF5B4E.6090101@sipsolutions.net>
Date: Tue, 02 Aug 2005 13:38:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>,
       debian-powerpc@lists.debian.org
Subject: Re: powerbook power-off and 2.6.13-rc[3,4]
References: <1122904460.6491.41.camel@localhost.localdomain> <1122905228.6881.9.camel@localhost> <1122907136.31350.45.camel@localhost.localdomain> <20050802111754.GC1390@elf.ucw.cz>
In-Reply-To: <20050802111754.GC1390@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Can you try without USB?
>
Not really. The keyboard is USB, and there's no PS/2 connector. I guess 
I maybe could do it via a timer, unload the modules and then have it 
shut down afterwards...

> With USB but without experimental
>CONFIG_USB_SUSPEND?
>  
>
I don't have USB_SUSPEND enabled, IIRC (don't have the PB with me, but 
I'm pretty sure I checked this yesterday. If you don't hear back, assume 
it wasn't enabled)

johannes
