Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVDLLh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVDLLh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVDLLfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:35:43 -0400
Received: from webapps.arcom.com ([194.200.159.168]:39438 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262340AbVDLLdv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:33:51 -0400
Message-ID: <425BB219.2040802@cantab.net>
Date: Tue, 12 Apr 2005 12:33:45 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: incoming
References: <20050412032322.72d73771.akpm@osdl.org>	<425BAAB3.7070605@cantab.net> <20050412041045.78e29f0e.akpm@osdl.org>
In-Reply-To: <20050412041045.78e29f0e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2005 11:40:54.0562 (UTC) FILETIME=[7C542820:01C53F54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> David Vrabel <dvrabel@cantab.net> wrote:
> 
>>Is there any chance that in the future that these patch sets get posted
>> all to one thread?
> 
> I never got around to setting that up, plus the Subject:s pretty quickly
> become invisible when they're indented 198 columns in GUI MUAs.

I meant something like this:

[patch 000/100]  Foo-ize the baz.
   [patch 001/100] Frob the baz
   [patch 002/100] baz cleanups
   [patch 003/100] apply foo-ization to baz

Rather than

[patch 000/100] Foo-ize the baz.
   [patch 001/100] Frob the baz
     [patch 002/100] baz cleanups
       [patch 003/100] apply foo-ization to baz

Which would (as you rightly pointed out) be ludicrous.

i.e., all the patches are replys to the summary.

David Vrabel
