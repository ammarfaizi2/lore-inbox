Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVCRX2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVCRX2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVCRX1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:27:00 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:15207 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262096AbVCRXZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:25:49 -0500
Message-ID: <423B6373.8030107@yahoo.com.au>
Date: Sat, 19 Mar 2005 10:25:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>,
       "Bligh, Martin J." <mbligh@aracnet.com>
Subject: Re: Bug in __alloc_pages()?
References: <4238D1DC.8070004@us.ibm.com> <4238D8C1.3080805@yahoo.com.au> <423B52FE.6030101@us.ibm.com>
In-Reply-To: <423B52FE.6030101@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:

> 
> Agreed.  It seems unlikely, but not entirely impossible.  All it would 
> take is one sloppily coded driver, right?  How about this patch instead?
> 

Sure that would be fine with me. It kind of makes the logic
explicit, as Martin said.

Nick

