Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUJFBMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUJFBMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUJFBMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:12:06 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:21944 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266585AbUJFBL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:11:59 -0400
Message-ID: <41634659.8010206@yahoo.com.au>
Date: Wed, 06 Oct 2004 11:11:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] scheduler: remove NODE_BALANCE_RATE definitions
References: <1097024938.4065.65.camel@arrakis>
In-Reply-To: <1097024938.4065.65.camel@arrakis>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> NODE_BALANCE_RATE is defined all over the place, but used nowhere. 
> Let's remove it.
> 

Yep that looks good. Andrew, can you queue this for when 2.6.10 opens
please.
