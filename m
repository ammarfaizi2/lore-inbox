Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVDAARJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVDAARJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVDAAP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 19:15:56 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:64190 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262079AbVDAANR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 19:13:17 -0500
Message-ID: <424C9217.9000205@yahoo.com.au>
Date: Fri, 01 Apr 2005 10:13:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Low file-system performance for 2.6.11 compared to 2.4.26
References: <Pine.LNX.4.61.0503311129360.4710@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503311129360.4710@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> For those interested, some file-system tests and a test-tools
> are attached.
> 

I'll give it a run when I get a chance. Thanks.
In the meantime, can you try with different io schedulers?

> Also, my .signature disappeared during the file-system tests.
> There were no errors and e2fsck thinks everything is fine!
> 

You seem to be constantly plagued by gremlins. I don't
know whether to laugh or cry.

