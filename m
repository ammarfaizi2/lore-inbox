Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbVFXB0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVFXB0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVFXB0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:26:46 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:51286 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262983AbVFXB0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:26:40 -0400
Message-ID: <42BB610E.8000705@yahoo.com.au>
Date: Fri, 24 Jun 2005 11:25:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au> <42BA5FC8.9020501@yahoo.com.au> <42BA5FE8.2060207@yahoo.com.au> <20050623095153.GB3334@holomorphy.com> <42BA8FA5.2070407@yahoo.com.au> <20050623220812.GD3334@holomorphy.com> <42BB43FB.1060609@yahoo.com.au> <20050624005952.GE3334@holomorphy.com>
In-Reply-To: <20050624005952.GE3334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>>I wouldn't pretend to be able to fix every bug everywhere in the
>>kernel myself.
> 

> If you can't handle the sweep, you have no business writing the patch.
> 

Let me just say that where I have introduced incompatibilities
I will try to look through drivers and arch code. I can't look
through and find everything that is already buggy though.

Send instant messages to your online friends http://au.messenger.yahoo.com 
