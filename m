Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTHGSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270416AbTHGSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:31:29 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:54938 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270384AbTHGSb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:31:27 -0400
Date: Thu, 07 Aug 2003 11:30:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-ID: <37150000.1060281047@[10.10.2.4]>
In-Reply-To: <3F321115.80606@cyberone.com.au>
References: <20030806223716.26af3255.akpm@osdl.org>	<28050000.1060237907@[10.10.2.4]> <20030807000542.5cbf0a56.akpm@osdl.org> <3F320DFC.6070400@cyberone.com.au> <3F32108A.2010000@cyberone.com.au> <3F321115.80606@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Andrew and or Martin, please test attached patch.
>> Thanks.
>> 
> 
> Well, one of the WARN conditions I put in there is clearly
> redundant...

Yeah, that patch fixes it.

Thanks,

M.

