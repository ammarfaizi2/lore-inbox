Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129987AbQKLTbk>; Sun, 12 Nov 2000 14:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130313AbQKLTba>; Sun, 12 Nov 2000 14:31:30 -0500
Received: from [216.161.55.93] ([216.161.55.93]:35823 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129987AbQKLTbO>;
	Sun, 12 Nov 2000 14:31:14 -0500
Date: Sun, 12 Nov 2000 11:31:07 -0800
From: Greg KH <greg@wirex.com>
To: Gerald Haese <Gerald.Haese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse stops working
Message-ID: <20001112113107.B23154@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Gerald Haese <Gerald.Haese@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <00111101012003.01860@dose> <20001110164006.E1229@wirex.com> <00111111194700.00657@dose>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00111111194700.00657@dose>; from Gerald.Haese@gmx.de on Sat, Nov 11, 2000 at 11:19:47AM +0100
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 11:19:47AM +0100, Gerald Haese wrote:
>  18:      14845      14797   IO-APIC-level  usb-uhci

Can you try the uhci.o host controller driver, to see if it has the same
problem?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
