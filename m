Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbRHKTcE>; Sat, 11 Aug 2001 15:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268809AbRHKTbz>; Sat, 11 Aug 2001 15:31:55 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:59024 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S268792AbRHKTbn>; Sat, 11 Aug 2001 15:31:43 -0400
Date: Sat, 11 Aug 2001 15:31:40 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
In-Reply-To: <20010811125035.A6428@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0108111527360.15826-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001, Eric S. Raymond wrote:

> Server case.  Seems to be running pretty cool -- the processor heatsinks
> are warm to the touch but not hot.  We've got a power-supply fan, two coolers,
> and two case fans.  Did you find you needed more than that?

Depends on how many drives you've got in the case.  The dual Athlon I'm
using has three case fans: two pulling air out from just below the
power supply and one drawing air into the case at the front.  The only
crashes I've experienced on the machine were caused by kernel bugs. =)

		-ben

-- 
"The world would be a better place if Larry Wall had been born in
Iceland, or any other country where the native language actually
has syntax" -- Peter da Silva

