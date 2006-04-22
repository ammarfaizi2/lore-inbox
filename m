Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWDVSvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWDVSvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWDVSvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:51:52 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:30655 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750837AbWDVSvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:51:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dUxJtdaRXoLXOzU8+gcF8NqrLgb/lwXawuFRIshcMsq/U4jZwtcwbaiMSozZPMeVJ+9o09DJ3IXYckr1POccJ9zBKhe/fdMuY75TWbFBvWiM0/if9RV8QcHZi9QJGcmCVQxUP9pw8Bt/aNQ8+ZOV4EI3gSGKnt2p9YX8FWQTkcQ=  ;
Message-ID: <444A7B44.1060504@yahoo.com.au>
Date: Sun, 23 Apr 2006 04:51:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [rfc][patch] radix-tree: direct data
References: <20060422183154.GF30503@wotan.suse.de>
In-Reply-To: <20060422183154.GF30503@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> This saves around 16MB in tags on my 4GB G5 with a couple of kernel source
                             ^^^^
Make that `radix_tree_node'

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
