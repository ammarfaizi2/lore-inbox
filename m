Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUHBQ1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUHBQ1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUHBQ1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:27:33 -0400
Received: from mail.tmr.com ([216.238.38.203]:27655 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266604AbUHBQ1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:27:30 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ide-cd problems
Date: Mon, 02 Aug 2004 12:30:37 -0400
Organization: TMR Associates, Inc
Message-ID: <celpmo$gff$1@gatekeeper.tmr.com>
References: <20040731210257.GA22560@bliss><20040731210257.GA22560@bliss> <cehqak$1pq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1091463704 16879 192.168.12.100 (2 Aug 2004 16:21:44 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <cehqak$1pq$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:

> Remember that it is still possible to write CDs through ide-cd in 2.4.x 
> using some pre-alpha code in cdrecord:
> 
> cdrecord dev=ATAPI:1,1,0 image.iso
> 
But... doesn't that require access to the sg device?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
