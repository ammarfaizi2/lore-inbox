Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWCXSyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWCXSyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWCXSyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:54:43 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:29375 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932192AbWCXSym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:54:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=t8kmQPJBd1OaafMENO1tZUDkXw7oewYeE+XWnKrWwGUEe2d6hS4BcolzZa864QuywW1aDkdKk5SvuLsuG5fj4iSphLs3P3VfnhgMKf5gptCfiVVOWA5UAdoDOQtc2vGAlquK+3Wcp9yA/2h30tMHlld++oNlisvieZOdoh6csY8=  ;
Message-ID: <44242D4D.40702@yahoo.com.au>
Date: Sat, 25 Mar 2006 04:33:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>
In-Reply-To: <44242A3F.1010307@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Eric, Herbert,
> 
> I think it is quite clear, that without some agreement on all these 
> virtualization issues, we won't be able to commit anything good to 
> mainstream. My idea is to gather our efforts to get consensus on most 
> clean parts of code first and commit them one by one.
> 
> The proposal is quite simple. We have 4 parties in this conversation 
> (maybe more?): IBM guys, OpenVZ, VServer and Eric Biederman. We discuss 
> the areas which should be considered step by step. Send patches for each 
> area, discuss, come to some agreement and all 4 parties Sign-Off the 
> patch. After that it goes to Andrew/Linus. Worth trying?

Oh, after you come to an agreement and start posting patches, can you
also outline why we want this in the kernel (what it does that low
level virtualization doesn't, etc, etc), and how and why you've agreed
to implement it. Basically, some background and a summary of your
discussions for those who can't follow everything. Or is that a faq
item?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
