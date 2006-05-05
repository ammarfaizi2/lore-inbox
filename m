Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWEEUGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWEEUGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWEEUGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:06:46 -0400
Received: from dvhart.com ([64.146.134.43]:57823 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751202AbWEEUGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:06:46 -0400
Message-ID: <445BB050.4040309@mbligh.org>
Date: Fri, 05 May 2006 13:06:40 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nuri Jawad <lkml@jawad.org>
Cc: Dave Jones <davej@redhat.com>, Martin Mares <mj@ucw.cz>,
       Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com> <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz> <20060505152748.GA22870@redhat.com> <mj+md-20060505.153608.7268.albireo@ucw.cz> <20060505154638.GE22870@redhat.com> <mj+md-20060505.154834.7444.albireo@ucw.cz> <20060505160009.GB25883@redhat.com> <Pine.LNX.4.64.0605052131580.28721@pc>
In-Reply-To: <Pine.LNX.4.64.0605052131580.28721@pc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Go buy a new laptop because someone else has a utopian view on how 
>> hardware should be?
> 
> You mean deciding not to silently ignore errors is having a utopian 
> view? Are we talking about Linux or kernel32.dll?
> 
>> When a user can't do *anything* about it, it's useless, and serves
>> as nothing but a cause for concern. "Oh no, is my laptop dying?".
> 
> Laptops come with Windows XP pre-installed for those users, what was 
> your problem again?

Sorry, but these comparisons to Windows are just childish.

Linux is not obliged to spit out meaningless, unhelpful error messages,
and be as user-hostile as possible. It's not a good trait. The current
error message is wrong ... if we can come up with something useful to
print, then great. But throwing 'Windows' around is not useful, and
neither are crappy, incorrect errors.

M.
