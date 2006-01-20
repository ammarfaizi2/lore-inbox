Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWATVHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWATVHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWATVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:07:04 -0500
Received: from zrtps0kn.nortel.com ([47.140.192.55]:49111 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP id S932184AbWATVHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:07:02 -0500
Message-ID: <43D150CC.7090508@nortel.com>
Date: Fri, 20 Jan 2006 15:06:20 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Loftis <mloftis@wgops.com>
CC: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com> <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr> <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com> <20060120194331.GA8704@kroah.com> <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2006 21:06:23.0184 (UTC) FILETIME=[5E444500:01C61E05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis wrote:

> And with nowhere to put patches that end up in 
> maintenance releases we're forced to maintain our own private forks, and 
> likely, because of the GPL, also publish these forks and incur all the 
> costs associated with that directly, and hope they don't become 
> popular/wanted outside of the customer base they're intended for, or 
> skirt the GPL, and only allow customers access to this stuff.

You do realize that if you ship the code along with the product then 
you're fully compliant to the GPL? Your customers can do whatever they 
want with the code, but your obligations are satisfied.

Chris
