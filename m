Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWCUMzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWCUMzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWCUMzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:55:11 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:18559 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751625AbWCUMzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:55:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=078UmlnGNtsxpj24mSTfuYv1PeDCO1PhF5Vexky59DuALhzK0/OAoXGBNFGfT/HpTFHW4Cv1Ksqb1VZ8hRyNQZpaDX/OWHTB8Voawch3+0UHG7EsN87SXIpQPQO7KdjlByycdbW7hI27GvL20iFEudMQBAjCIrjRVFOl+XjhV/w=  ;
Message-ID: <441FEFBB.9000709@yahoo.com.au>
Date: Tue, 21 Mar 2006 23:21:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][3/8] mm: get_user_pages interface change
References: <bc56f2f0603200537g35d2bfd5m@mail.gmail.com>
In-Reply-To: <bc56f2f0603200537g35d2bfd5m@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> Adjust references of get_user_pages.
> 

You typically do this in the same step as you adjust
get_user_pages itself.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
