Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131217AbQKATFV>; Wed, 1 Nov 2000 14:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbQKATFL>; Wed, 1 Nov 2000 14:05:11 -0500
Received: from [216.161.55.93] ([216.161.55.93]:42735 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131217AbQKATFD>;
	Wed, 1 Nov 2000 14:05:03 -0500
Date: Wed, 1 Nov 2000 11:04:26 -0800
From: Greg KH <greg@wirex.com>
To: "Carlos E. Gorges" <carlos@vb.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ipac usb abnt2 (others?) keyboard fix
Message-ID: <20001101110426.A5890@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	"Carlos E. Gorges" <carlos@vb.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00110100263206.01274@quarks.techlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00110100263206.01274@quarks.techlinux>; from carlos@vb.com.br on Tue, Oct 31, 2000 at 11:46:26PM -0200
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 11:46:26PM -0200, Carlos E. Gorges wrote:
> 2.2.17 fix need a suse usb backport patch ( I use test2-pre2 ).

FWIW, if you are using USB on the 2.2.x series, use 2.2.18preX as the
backport patch is in there, plus a whole lot of other updates.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
