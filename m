Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267666AbUIJRzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUIJRzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUIJRzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:55:42 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:52156 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267666AbUIJRwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:52:24 -0400
Message-ID: <4141E9D3.9080109@nortelnetworks.com>
Date: Fri, 10 Sep 2004 11:52:19 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Hugh Dickins <hugh@veritas.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: having problems with remap_page_range() and virt_to_phys()
References: <Pine.LNX.4.44.0409101501530.16728-100000@localhost.localdomain> <4141C49E.3070509@nortelnetworks.com>
In-Reply-To: <4141C49E.3070509@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:

> So did I...the code finishes without errors, but the assembly language 
> part doesn't work properly.  (And it does work with another method of 
> getting memory, but that method breaks as soon as you go highmem...)

HIGHPTE, I should say.

Chris
