Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129874AbQKIRQw>; Thu, 9 Nov 2000 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQKIRQm>; Thu, 9 Nov 2000 12:16:42 -0500
Received: from [216.161.55.93] ([216.161.55.93]:56567 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129159AbQKIRQc>;
	Thu, 9 Nov 2000 12:16:32 -0500
Date: Thu, 9 Nov 2000 09:15:33 -0800
From: Greg KH <greg@wirex.com>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
Cc: "'David Ford'" <david@linux.com>, linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
Message-ID: <20001109091533.A14922@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	"Dunlap, Randy" <randy.dunlap@intel.com>,
	'David Ford' <david@linux.com>, linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC82@orsmsx31.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC82@orsmsx31.jf.intel.com>; from randy.dunlap@intel.com on Thu, Nov 09, 2000 at 09:06:31AM -0800
X-Operating-System: Linux 2.4.0-test10 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 09:06:31AM -0800, Dunlap, Randy wrote:
> 
> Bus-powered != self-powered.
> 
> Self-powered means that it has its own power cord.
> 
> Bus-powered means that it gets its power from the USB cable.

You're right, I used the wrong terms (but used the correct
descriptions).  I meant that "bus-powered" hubs are flaky and have
problems, like Randy said.

Sorry any confusion this might have caused.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
