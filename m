Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWBIIiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWBIIiG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWBIIiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:38:06 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:36216 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750798AbWBIIiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:38:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=p7UMUvczMZc7ed2dkCSR0fPzMq3hOWWOj/oDEfx8Nz9tTzOi4CuJ3tYcsDxC/aIsg41ehqO2uUgE/MiPlrdLlotp35JmuYkBgAn8LLncFntkPBFkghHvupqQHkYBt2R6ia26DDPZKEjoTQZRXIhDYEZRFeYowwtpt0YHoSUzmtQ=  ;
Message-ID: <43EAFF6D.1040604@yahoo.com.au>
Date: Thu, 09 Feb 2006 19:38:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: MIke Galbraith <efault@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
References: <1139473463.8028.13.camel@homer>
In-Reply-To: <1139473463.8028.13.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIke Galbraith wrote:
> Greetings,
> 
> Excuse me if this is already known, I've been too busy tinkering to read
> lkml.
> 

It should be fixed as of current -git (not sure about the latest
-mm though). It would be good if you could verify that 2.6.16-rc2-git7
works OK for you.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
