Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268806AbUHUB1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268806AbUHUB1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 21:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268810AbUHUB1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 21:27:00 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:53630 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268806AbUHUB07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 21:26:59 -0400
Message-ID: <4126A4DC.1050103@yahoo.com.au>
Date: Sat, 21 Aug 2004 11:26:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com>
In-Reply-To: <200408201144.49522.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Friday, August 20, 2004 6:19 am, Andrew Morton wrote:
> 
>>- This is (very) lightly tested.  Mainly a resync with various parties.
> 
> 
> Woo-hoo!  This boots *without changes* on a 512p Altix!  Now to re-run the 
> profiles and try wli's new per-cpu profiling buffers.
> 

What changes were needed to achieve this previously?
