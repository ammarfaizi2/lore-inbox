Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUEGRSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUEGRSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 13:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbUEGRSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 13:18:43 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:21778 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263697AbUEGRSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 13:18:41 -0400
Message-ID: <409BC67F.4030701@techsource.com>
Date: Fri, 07 May 2004 13:25:19 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Oliver Pitzeier <oliver@linux-kernel.at>, linux-kernel@vger.kernel.org
Subject: Re: Strange Linux behaviour!?
References: <409B4494.5253316B@melbourne.sgi.com> <013001c4340d$e9860470$d50110ac@sbp.uptime.at> <20040507093455.A27829@infradead.org>
In-Reply-To: <20040507093455.A27829@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig wrote:
> On Fri, May 07, 2004 at 10:33:02AM +0200, Oliver Pitzeier wrote:
> 
>>cd /usr
>>mkdir test
>>mkdir: cannot create directory `test': No space left on device
> 
> 
> ?Have you checked whether you're out of inodes?
> 


What happens when Linux runs out of inodes?  Why would it?  Doesn't it 
create more?

