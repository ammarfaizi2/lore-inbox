Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUJLNwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUJLNwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUJLNwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 09:52:07 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:36748 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263540AbUJLNwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 09:52:05 -0400
Message-ID: <416BE10D.5040208@yahoo.com.au>
Date: Tue, 12 Oct 2004 23:50:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Ronny V. Vindenes" <s864@ii.uib.no>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: CFQ v2 high cpu load fix(?)
References: <1097579760.4086.27.camel@tentacle125.gozu.lan> <416BBF48.4070102@yahoo.com.au> <20041012121227.GA1754@suse.de> <416BCE4A.7060403@yahoo.com.au> <20041012132214.GA24931@suse.de>
In-Reply-To: <20041012132214.GA24931@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Oct 12 2004, Nick Piggin wrote:

>>Cool. Can you queue up a patch for when -mm opens again, or shall I?
>>I can't imagine it should cause any problems but a bit of testing
>>would be wise.
> 
> 
> Testing is always good, but maybe Andrew can take it now but just not
> feed to Linus until after 2.6.9?
> 

If Andrew doesn't mind, then yeah that would be nice.
