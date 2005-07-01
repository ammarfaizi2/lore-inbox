Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263437AbVGATeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbVGATeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbVGATeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:34:25 -0400
Received: from [62.206.217.67] ([62.206.217.67]:14317 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S263437AbVGATeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:34:20 -0400
Message-ID: <42C59ABA.1070305@trash.net>
Date: Fri, 01 Jul 2005 21:34:18 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: Patrick Jenkins <patjenk@wam.umd.edu>, linux-kernel@vger.kernel.org,
       Maillist netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] multipath routing algorithm, better patch
References: <Pine.GSO.4.61.0506302014160.7400@rac1.wam.umd.edu> <42C4919A.5000009@trash.net> <20050701174117.GW16076@postel.suug.ch>
In-Reply-To: <20050701174117.GW16076@postel.suug.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:
> * Patrick McHardy <42C4919A.5000009@trash.net> 2005-07-01 02:43
> 
>>If it isn't set correctly its an iproute problem. Did you actually
>>experience any problems?
> 
> Well, my patch for iproute2 to enable multipath algorithm selection
> is currently being merged to Stephen together with the ematch bits.
> We had to work out a dependency on GNU flex first (the berkley
> version uses the same executable names) so the inclusion was
> delayed a bit.

So its no problem but simply missing support. BTW, do you know if
Stephen's new CVS repository is exported somewhere?

Regards
Patrick
