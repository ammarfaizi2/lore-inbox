Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbRGBAWD>; Sun, 1 Jul 2001 20:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266299AbRGBAVw>; Sun, 1 Jul 2001 20:21:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62727 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266298AbRGBAVq>; Sun, 1 Jul 2001 20:21:46 -0400
Message-ID: <3B3FBE8C.80803@zytor.com>
Date: Sun, 01 Jul 2001 17:21:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Riley Williams <rhw@MemAlpha.CX>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal signal 11]
In-Reply-To: <Pine.LNX.4.33.0107020117210.18977-100000@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:

> Hi Peter.
> 
>  >> Wasn't 2.2.12 the kernel that included the `lock halt` bug patch?
> 
>  > Perhaps, but is has absolutely nothing to do with the rest of
>  > this discussion.
> 
> The `lock halt` bug patch was specific to the Cyrix processors (not to
> be confused with the `lock registers` patch for the Intel processors,
> and I noted that the processor in question was a Cyrix one, hence the
> comment.
> 


Oh.  Sorry, I don't know about "lock halt" and its effects.  However, if 
it refers to the instruction sequence LOCK HLT I find it hard to believe 
it would have the symptoms described.

	-hpa


