Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVGNXwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVGNXwC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVGNXvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:51:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262598AbVGNXu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:50:58 -0400
Date: Thu, 14 Jul 2005 16:49:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <1121384499.4535.82.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0507141648070.19183@g5.osdl.org>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>  <1121383050.4535.73.camel@mindpipe>
  <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org> <1121384499.4535.82.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Lee Revell wrote:
> 
> And I'm incredibly frustrated by this insistence on hard data when it's
> completely obvious to anyone who knows the first thing about MIDI that
> HZ=250 will fail in situations where HZ=1000 succeeds.

Ok, guys. How many people have this MIDI thing? How many of you can't be 
bothered to set the default to suit your usage?

> It's straight from the MIDI spec.  Your argument is pretty close to "the
> MIDI spec is wrong, no one can hear the difference between 1ms and 4ms".

No.

YOUR argument is "nobody else matters, only I do".

MY argument is that this is a case of give and take. 

		Linus
