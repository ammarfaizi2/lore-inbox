Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUD2PLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUD2PLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbUD2PLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:11:32 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:32006 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264815AbUD2PKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:10:44 -0400
Message-ID: <40911C01.80609@techsource.com>
Date: Thu, 29 Apr 2004 11:15:13 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Marc Boucher <marc@linuxant.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:
> On Wed, 28 Apr 2004, Marc Boucher wrote:
> 
> 
>>At the same time, I think that the "community" should, without 
>>relinquishing its principles, be less eager before getting the facts to 
>>attack people and companies trying to help in good faith, and be more 
>>realistic when it comes to satisfying practical needs of ordinary 
>>users.
> 
> 
> I wouldn't be averse to changing the text the kernel prints
> when loading a module with an incompatible license. If the
> text "$MOD_FOO: module license '$BLAH' taints kernel." upsets
> the users, it's easy enough to change it.
> 
> How about the following?
> 
> "Due to $MOD_FOO's license ($BLAH), the Linux kernel community
> cannot resolve problems you may encounter. Please contact
> $MODULE_VENDOR for support issues."


Sounds very "politically correct", but certainly more descriptive and 
less alarming.

