Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVCDA1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVCDA1U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVCDAXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:23:33 -0500
Received: from [220.233.7.36] ([220.233.7.36]:64230 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262812AbVCDAVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:21:41 -0500
Date: Fri, 4 Mar 2005 11:19:30 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Chris Friesen <cfriesen@nortel.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304001930.GF30616@zip.com.au>
References: <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <42274171.3030702@nortel.com> <20050303165940.GA11144@kroah.com> <1109893901.21780.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109893901.21780.68.camel@localhost.localdomain>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 11:51:42PM +0000, Alan Cox wrote:
> -ac is essentially base security fixes + working IDE locking + pwc +
> fixes for the bugs everyone hit that needed fixing urgently. I consider
> working locking on my storage essential because I like my data to still
> be there.

Working IDE locking? Does this mean if I have 2 promise cards, a HD
on each card and I copy from one to the other it wont all blow up in my
face?

Please say yes. :)

-- 
    Red herrings strewn hither and yon.
