Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRHXNAG>; Fri, 24 Aug 2001 09:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRHXM7z>; Fri, 24 Aug 2001 08:59:55 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:43718 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S271278AbRHXM7j>;
	Fri, 24 Aug 2001 08:59:39 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
In-Reply-To: <E15a1rW-000MM9-00@f10.mail.ru> <20010823143443.F14302@cpe-24-221-152-185.az.sprintbbd.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 24 Aug 2001 14:59:37 +0200
In-Reply-To: Tom Rini's message of "Thu, 23 Aug 2001 14:34:43 -0700"
Message-ID: <d3ofp5wr46.fsf@lxplus035.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> On Fri, Aug 24, 2001 at 01:18:02AM +0400, Samium Gromoff wrote:
>> but imagine the X arch hacker does not like python, and
>> nevertheless needs to port it on arch X.  still fun?

Tom> Well I know python is endian-clean.  I'd suspect it's even
Tom> 32/64bit clean.  So it's not a matter of 'port' but compile.  And
Tom> Linus has done things which have made lots of kernel hackers
Tom> scratch their head for a while.  (Jump out of this fire and into
Tom> the min/max macros in 2.4.9 fire to see what I mean).

Again, please try and do real porting work before you make such silly
statements. Perl is 32/64 little/big-endian clean ... and still it's
the absolutely worst app to bring up (even X tends to be easier).

There is a lot more to this than meets the eye!

Jes
