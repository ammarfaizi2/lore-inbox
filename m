Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbWKGNWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWKGNWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWKGNWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:22:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:24285 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932618AbWKGNWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:22:41 -0500
Message-ID: <4550889C.2020708@qumranet.com>
Date: Tue, 07 Nov 2006 15:22:36 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Pavel Machek <pavel@ucw.cz>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 12/14] KVM: x86 emulator
References: <454E4941.7000108@qumranet.com>	 <20061105204035.DF0F62500A7@cleopatra.q>	 <20061107124912.GA23118@elf.ucw.cz>  <4550823E.2070108@qumranet.com> <1162904459.3138.142.camel@laptopd505.fenrus.org>
In-Reply-To: <1162904459.3138.142.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> The entire patchset is GPL'ed.  Do you mean to make it explicit?  If so, 
>> how?  I'd rather not copy the entire license into each file.
>>     
>
> a simple one liner like
> "This file is licensed under the terms of the GPL v2 license"
> (add "or later" if you feel like doing that)
> is going to be generally useful. 
>
> At least many many legal departments really prefer at least that minimum
> line to be there for each file; some even want a much longer blurb.
>   

Okay.  I hate to use the word "official", but is there an official 
position on this somewhere?

-- 
error compiling committee.c: too many arguments to function

