Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVCHWCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVCHWCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVCHWCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:02:23 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:7560 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261607AbVCHWCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:02:15 -0500
Message-ID: <422E2223.5060906@tmr.com>
Date: Tue, 08 Mar 2005 17:07:31 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
References: <20050304124431.676fd7cf.akpm@osdl.org><20050304124431.676fd7cf.akpm@osdl.org> <4228D43E.1040903@pobox.com>
In-Reply-To: <4228D43E.1040903@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Unless it's crashing for people, stack usage is IMO a wanted-fix not 
> needed-fix.
> 
> 
>> nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
> 
> 
> is this critical?

Wasn't part of the Linus proposal that it had to fix an oops or 
non-functional feature?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
