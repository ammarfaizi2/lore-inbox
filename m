Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130019AbRBLV6o>; Mon, 12 Feb 2001 16:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130097AbRBLV6e>; Mon, 12 Feb 2001 16:58:34 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:43021 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130019AbRBLV6W>;
	Mon, 12 Feb 2001 16:58:22 -0500
Message-ID: <3A885CFF.2010109@megapathdsl.net>
Date: Mon, 12 Feb 2001 14:00:31 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-pre2 i686; en-US; m18) Gecko/20010208
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <3A83B6B0.8261F3CF@idb.hist.no> <3A83C4A1.5090903@megapathdsl.net> <20010211234718.K3748@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Hi!
> 
> 
>> Right.  Add the option.  Default to "spew mode",
>> but make it easy for distributions to show people
>> a non-threatening boot process.  
> 
> Wrong.

We're talking about an _option_.  In fact, it could 
be set up as a boot time parameter.  Then, if a boot
process gets wedged, the user can just reboot with
the option disabled.

I really don't understand why this is such a hot
button for some people.  I repeat "option."

>> Since, as Christophe mentions, the boot messages would
>> still be accessible via CTRL-ALT-F2, I don't see what 
>> the problem is with at least making this an option.
> 
> If your system crashes hard, you have only graphical logo to stare
> at. Any warning messages are hidden. Not good.

Again.  Boot parameter.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
