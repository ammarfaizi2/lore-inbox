Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVC3Ldp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVC3Ldp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 06:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVC3Ldp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 06:33:45 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:25242 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261871AbVC3Ldm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 06:33:42 -0500
Message-ID: <424A8E58.6050607@f2s.com>
Date: Wed, 30 Mar 2005 12:32:40 +0100
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Hugh Dickins <hugh@veritas.com>, "David S. Miller" <davem@davemloft.net>,
       nickpiggin@yahoo.com.au, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
References: <Pine.LNX.4.61.0503292223090.18131@goblin.wat.veritas.com>  <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> <4243A257.8070805@yahoo.com.au> <20050325092312.4ae2bd32.davem@davemloft.net> <20050325162926.6d28448b.davem@davemloft.net> <22627.1112179577@redhat.com>
In-Reply-To: <22627.1112179577@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>>I suspect Ian can live without his printk!

I expect so, since arm26 doesnt boot yet. Hopefully once I get my 
current load of arm32 stuff done I'll get some time to revisit it.

arm26 mm is quite broken right now.
