Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVFIA1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVFIA1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVFIA0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:26:37 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:59009 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261408AbVFIAYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:24:07 -0400
Message-ID: <42A78C23.70303@yahoo.com.au>
Date: Thu, 09 Jun 2005 10:24:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "M.Baris Demiray" <baris@labristeknoloji.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12-rc6-mm1] add allowed CPUs check into	find_idlest_{group|cpu}()
References: <42A66485.8010208@labristeknoloji.com> <1118191744.5104.49.camel@npiggin-nld.site> <42A75E1A.8030803@labristeknoloji.com>
In-Reply-To: <42A75E1A.8030803@labristeknoloji.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M.Baris Demiray wrote:
> 

> 
> You're right, I got it. Updated version is appended.
> 

Looks good, thanks. I'll test it here and queue it up to
send to Andrew. Will you send me a Signed-off-by: line to
go with that?


-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
