Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131382AbQK2TWi>; Wed, 29 Nov 2000 14:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131678AbQK2TWS>; Wed, 29 Nov 2000 14:22:18 -0500
Received: from [216.161.55.93] ([216.161.55.93]:18673 "EHLO blue.int.wirex.com")
        by vger.kernel.org with ESMTP id <S131382AbQK2TWP>;
        Wed, 29 Nov 2000 14:22:15 -0500
Date: Wed, 29 Nov 2000 10:52:37 -0800
From: Greg KH <greg@wirex.com>
To: Wayne Price <Wayne.Price@vil.ite.mee.com>
Cc: linux-kernel@vger.kernel.org, W.Price@acropolis-solutions.co.uk
Subject: Re: Question: Serial port device drivers...
Message-ID: <20001129105237.B1196@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
        Wayne Price <Wayne.Price@vil.ite.mee.com>,
        linux-kernel@vger.kernel.org, W.Price@acropolis-solutions.co.uk
In-Reply-To: <3A24F9C7.11F5D80D@vil.ite.mee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A24F9C7.11F5D80D@vil.ite.mee.com>; from Wayne.Price@vil.ite.mee.com on Wed, Nov 29, 2000 at 12:42:47PM +0000
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 12:42:47PM +0000, Wayne Price wrote:
> 
> Has this been done before, and does anyone have any sample code or
> hints as to what I need to do? We are using kernel 2.2.16 (from
> RedHat-7.0).

You might want to take a look at the Axis Bluetooth stack for Linux
(www.axis.com).  It lives above the serial driver and sounds like it
does what you are looking to do.

Hope this helps,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
