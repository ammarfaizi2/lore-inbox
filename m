Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbSKOPxa>; Fri, 15 Nov 2002 10:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266369AbSKOPxa>; Fri, 15 Nov 2002 10:53:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40199 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266359AbSKOPx3>;
	Fri, 15 Nov 2002 10:53:29 -0500
Message-ID: <3DD51A13.5070405@pobox.com>
Date: Fri, 15 Nov 2002 11:00:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Khoa Huynh <khoa@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
References: <OF17E41902.5E012443-ON85256C72.00253F4E@pok.ibm.com>
In-Reply-To: <OF17E41902.5E012443-ON85256C72.00253F4E@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khoa Huynh wrote:

> Also if you have already used this kernel Bugzilla database,
> you might have noticed that many components are currently
> owned by Martin or myself.  As Martin pointed out in his
> announcement, this is not because we are "egomaniacs", but
> rather because the rightful owners (or those who know enough
> about these components and want to volunteer to work bugs)
> have not been registered yet.  Martin and I will try our best
> to turn over these components to their rightful "owners"
> as soon as we can.  We are still learning the "ropes" on
> how to do this effectively, so it will take some time
> (not too long we hope).  Thanks.



IMO it would probably be better for you two if all bugs without "real" 
owners had bugs assigned to notaperson@bugzilla.kernel.org, or something 
like that.  That will not only ease useless emails sent to you and 
Martin and other admins, but also make it easier for kernel hackers to 
figure out which bugs are _really_ unassigned and need owners.

	Jeff



