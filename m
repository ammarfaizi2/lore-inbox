Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSGWT6w>; Tue, 23 Jul 2002 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSGWT6v>; Tue, 23 Jul 2002 15:58:51 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5646 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318207AbSGWT6v>; Tue, 23 Jul 2002 15:58:51 -0400
Date: Tue, 23 Jul 2002 17:01:32 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paul Larson <plars@austin.ibm.com>
cc: dmccr@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       <haveblue@us.ibm.com>
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
In-Reply-To: <1027454241.7700.34.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.44L.0207231701000.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2002, Paul Larson wrote:

> I was asking Dave McCracken and he mentioned that rmap and highmem pte
> don't play nice together.  I tried turning that off and it boots without
> error now.

OK, good to hear that.

> Someone might want to take a look at getting those two to
> work cleanly together especially now that rmap is in.

William Irwin has been working on this for a few days now ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

