Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317879AbSGWRq1>; Tue, 23 Jul 2002 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317925AbSGWRq1>; Tue, 23 Jul 2002 13:46:27 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:63404 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317879AbSGWRq0>; Tue, 23 Jul 2002 13:46:26 -0400
Message-ID: <3D3D96EF.30104@us.ibm.com>
Date: Tue, 23 Jul 2002 10:48:31 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Rik van Riel <riel@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com>	<1027377273.5170.37.camel@plars.austin.ibm.com> 	<20020722225251.GG919@holomorphy.com> <1027446044.7699.15.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> On Mon, 2002-07-22 at 17:52, William Lee Irwin III wrote:
> 
>>ISTR this compiler having code generation problems. I think trying to
>>reproduce this with a working i386 compiler is in order, e.g. debian's
>>2.95.4 or some similarly stable version.
> 
> That's exactly the one I was planning on trying it with.  Tried it this
> morning with the same error.  Three compilers later, I think this is
> looking less like a compiler error.  Any ideas?

Exactly _which_ 3 compilers?  I couldn't do it with egcs, but Debian's 
2.5.94 and 3.0 worked.

-- 
Dave Hansen
haveblue@us.ibm.com

