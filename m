Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965306AbWFAVHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965306AbWFAVHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbWFAVHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:07:45 -0400
Received: from dvhart.com ([64.146.134.43]:32659 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965306AbWFAVHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:07:44 -0400
Message-ID: <447F571D.6000000@mbligh.org>
Date: Thu, 01 Jun 2006 14:07:41 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Martin J. Bligh" <mbligh@google.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com> <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com> <20060531225013.GA7125@elte.hu> <Pine.LNX.4.64.0606011222230.17704@scrub.home> <447EFE86.7020501@google.com> <Pine.LNX.4.64.0606011659030.32445@scrub.home> <447F084C.9070201@google.com> <Pine.LNX.4.64.0606011742500.32445@scrub.home> <447F1BE4.5040705@mbligh.org> <Pine.LNX.4.64.0606012200260.32445@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606012200260.32445@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, if you don't want to enable a number of options, it's still better 
> to hide them completely. There are number of options by reorganizing the 
> debug menu a little, it only depends if we're talking here are about a -mm 
> only crutch or something which might be useful to more than a handful of 
> people. A few extra config options are not really a problem as long as 
> they are logically grouped together (instead of having to enable random 
> options all over the place).

How is the user meant to know which of your config options a particular
option is hidden under?

Same question for the developer as to where to put it?

Seems there are two isses - whether the naming is meaningful or not,
and whether you want to hide options under other options,or just flip
defaults ... does that sound correct?

M.
