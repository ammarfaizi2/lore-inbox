Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbQKMFPU>; Mon, 13 Nov 2000 00:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbQKMFPL>; Mon, 13 Nov 2000 00:15:11 -0500
Received: from [216.161.55.93] ([216.161.55.93]:34813 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129819AbQKMFO5>;
	Mon, 13 Nov 2000 00:14:57 -0500
Date: Sun, 12 Nov 2000 21:14:41 -0800
From: Greg KH <greg@wirex.com>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
Message-ID: <20001112211441.A24015@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, tytso@mit.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org>; from tytso@mit.edu on Sun, Nov 12, 2000 at 02:39:09PM -0500
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 02:39:09PM -0500, tytso@mit.edu wrote:
>      * USB: fix setting urb->dev in printer, acm, bluetooth, all serial
>        drivers (Greg KH) {CRITICAL} (test10-pre1)

Confirmed, this is in the latest version and is fixed.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
