Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWF1SQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWF1SQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWF1SQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:16:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39560 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750763AbWF1SQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:16:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Savochkin <saw@swsoft.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
	<20060628150605.A29274@castle.nmd.msu.ru>
	<m1sllpfckx.fsf@ebiederm.dsl.xmission.com>
	<20060628212240.A1833@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 12:14:41 -0600
In-Reply-To: <20060628212240.A1833@castle.nmd.msu.ru> (Andrey Savochkin's
	message of "Wed, 28 Jun 2006 21:22:40 +0400")
Message-ID: <m1mzbxdu5q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@swsoft.com> writes:

> Hi Eric,
>
> On Wed, Jun 28, 2006 at 10:51:26AM -0600, Eric W. Biederman wrote:
>> Andrey Savochkin <saw@swsoft.com> writes:
>> 
>> > One possible option to resolve this question is to show 2 relatively short
>> > patches just introducing namespaces for sockets in 2 ways: with explicit
>> > function parameters and using implicit current context.
>> > Then people can compare them and vote.
>> > Do you think it's worth the effort?
>> 
>> Given that we have two strong opinions in different directions I think it
>> is worth the effort to resolve this.
>
> Do you have time to extract necessary parts of your old patch?
> Or you aren't afraid of letting me draft an alternative version of socket
> namespaces basing on your code? :)

I'm not terribly afraid.  I can always say you did it wrong. :)

I don't think I am going to have time today.  But since this conversation
is slowing down and we are to getting into the technical details.  
I will try and find some time.

Eric
