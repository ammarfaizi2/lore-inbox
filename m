Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbUD2Avd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUD2Avd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUD2Avd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:51:33 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:63058 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262316AbUD2Av2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:51:28 -0400
Message-ID: <40904EF5.7080903@yahoo.com.au>
Date: Thu, 29 Apr 2004 10:40:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Marc Boucher <marc@linuxant.com>, Timothy Miller <miller@techsource.com>,
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
> 

I think something like that is much easier to decipher.


