Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWFZGEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWFZGEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFZGEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:04:04 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:22942 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932392AbWFZGEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:04:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KnXuY2cWoB3ILcqSJ4ruHJ8JHb3z3UT6hp1aQLnkq090kil88PXFfvK5L30p0AppJiGExCNM4dC9sxGP6hmRqvCTiUe4BO5s76Z/icKdACh7xbuUFGID7BCn/9bYzWRkPT6hHI2ifjrcDFHNn0AAVCmjo7cl2w8ng9JEaYlwmk8=  ;
Message-ID: <449F78D5.8040205@yahoo.com.au>
Date: Mon, 26 Jun 2006 16:04:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [patch] 2.6.17: lockless pagecache
References: <20060625163930.GB3006@wotan.suse.de> <449ECE2E.3080804@gmail.com>
In-Reply-To: <449ECE2E.3080804@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Nick Piggin napisał(a):
> 
>>Updated lockless pagecache patchset available here:
>>
>>ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.17/lockless.patch.gz
>>
> 
> 
> Here is my fix for this warnings
> WARNING: /lib/modules/2.6.17.1/kernel/fs/ntfs/ntfs.ko needs unknown symbol add_to_page_cache
> WARNING: /lib/modules/2.6.17.1/kernel/fs/ntfs/ntfs.ko needs unknown symbol add_to_page_cache

Thanks. Accidentally nuked that export.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
