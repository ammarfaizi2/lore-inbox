Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbTIBRBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbTIBQ6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:58:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:43955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264053AbTIBQyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:54:03 -0400
Date: Tue, 2 Sep 2003 09:41:10 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.4.22: OOPS on disconnect PL2303 adapter - see also 2.6.0-test4 - PL2303 annoyances
Message-ID: <20030902164110.GE17568@kroah.com>
References: <200309020115.29965.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309020115.29965.mhf@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 01:37:17AM +0800, Michael Frank wrote:
> After the troubles with 2.6, rebooted with 2.4.22, First use of USB
> with 2.4.22 ;) 
> 
> Behaviour same + an oops...
> 
> Sorry, the call trace DOES not make sense - I checked that I use the
> correct symbols ;

Known bug, use 2.6.

Sorry,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 01:37:17AM +0800, Michael Frank wrote:
> After the troubles with 2.6, rebooted with 2.4.22, First use of USB
> with 2.4.22 ;) 
> 
> Behaviour same + an oops...
> 
> Sorry, the call trace DOES not make sense - I checked that I use the
> correct symbols ;

Known bug, use 2.6.

Sorry,

greg k-h
