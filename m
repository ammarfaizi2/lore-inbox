Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUGWWBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUGWWBb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 18:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUGWWBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 18:01:31 -0400
Received: from mailgate2.sover.net ([209.198.87.64]:20223 "EHLO mx2.sover.net")
	by vger.kernel.org with ESMTP id S268058AbUGWWBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 18:01:18 -0400
Message-ID: <41018AAA.9080405@sover.net>
Date: Fri, 23 Jul 2004 18:01:14 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Adrian Bunk <bunk@fs.tum.de>, "R. J. Wysocki" <rjwysocki@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]: CONFIG_UNSUPPORTED
References: <20040721141524.GA12564@kroah.com> <20040722064952.GC20561@kroah.com> <20040722091335.A17187@home.com> <200407232106.41065.rjwysocki@sisk.pl> <20040723200416.GO19329@fs.tum.de> <20040723233533.GA19808@mars.ravnborg.org>
In-Reply-To: <20040723233533.GA19808@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>On Fri, Jul 23, 2004 at 10:04:17PM +0200, Adrian Bunk wrote:
>  
>
>>On Fri, Jul 23, 2004 at 09:06:40PM +0200, R. J. Wysocki wrote:
>>
>>>..
>>>2. Proposal
>>>
>>>I propose to introduce a new configuration option CONFIG_UNSUPPORTED, such 
>>><---------  big snip   --------->
>>>
>Stuff is marked OBSOLETE in Kconfig files, and text for menu option is
>reflecting this.
>This can well be overlooed if one does 'make oldconfig' only,
>but at least documented this way.
>
>	Sam
>
Good point.

A better name for this config option might be CONFIG_OBSOLETE, with the 
semantics described in R. J. Wysocki's original post.

- Steve


